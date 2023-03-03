Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E766A9746
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCCMag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCCMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:30:31 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827095B5F2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:30:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d6so1365082pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wKCLv1hgI86xhnJ8PFNiyFksPKMl3hpg2oT8pYQZNSw=;
        b=r+wRZBS/rNchorFCHPRKq4PVeBobHOUJa1wtGCGLSJgwilzMDQH3ehLoh/rn29QdmW
         dxg9EbpyYOhiZW4t3Fr+FGvRjR3keD9TAspcLBCCAeftqctPejsfxspLJbd4ab/5gXqj
         Qw8KGInTBYctfa0OlwZBBLfVd9SfLcImW7fvzIPVkftLnm5vAi82yih3Y4w32vqUC4Ts
         xp6SakQ0kTKLl8z77XI3BMtEBgWhj7zO03lhPihiSTSBNEwQcRXOVZg6vGXEYw/W4Rkg
         O1vOSu3ljTpsKMFOFy0hemO48BbkicInFTdMxatU2wWgYjkiGz9DmiiH36cUljAa79+e
         zS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKCLv1hgI86xhnJ8PFNiyFksPKMl3hpg2oT8pYQZNSw=;
        b=JwTEYH4C0o6lc6Ql5pYj2qws5H73IgiZEHql3OiOhrW6PYSS0T9SATsVsJTwvWh1Rv
         c+hc9f3pE/R2cLxC9yZJHZuPfbGCw2PvTGb8es/fsYvRd2+i9YKY8CfcKjFVzAoSvqqA
         E8FHo0pNY144YK/c667cG0nwGMP7Wv97Pr2GMAyzAwwJtA4adFWQKSCPlLdAdBj0lU6+
         zTiJeOTQ1cG5/5wEtnLBL2LzuSefsmCfnBxn6+uqy23QMSKmtwDXLTkY5HLguJaQhsOl
         8FN96SYQISVmmM4iHwkIP4StMB8beCkT3fln6OgANILUbsANHVj07Bg6lWsn8k/queb6
         SJMA==
X-Gm-Message-State: AO0yUKWEX2oDf/Vc9xFc4az1JRu4jgNm95PmC31cnOJNVWbX3iavgMUJ
        D9p4l7tgYRgm60w/8vfCkXCa
X-Google-Smtp-Source: AK7set97iZEg+efZSyPVoEaAWnXYHtkgTBA9aWCb/R6Ep2v8/b9tq4QhMQNui/I52feyiJqe6CkTLQ==
X-Received: by 2002:a62:7982:0:b0:5a9:d676:ae58 with SMTP id u124-20020a627982000000b005a9d676ae58mr2152089pfc.13.1677846629953;
        Fri, 03 Mar 2023 04:30:29 -0800 (PST)
Received: from thinkpad ([117.207.30.104])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b0058b927b9653sm1542681pfo.92.2023.03.03.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:30:29 -0800 (PST)
Date:   Fri, 3 Mar 2023 18:00:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v6] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230303123022.GA6782@thinkpad>
References: <20230213072133.5977-1-manivannan.sadhasivam@linaro.org>
 <20230303103407.GR2303077@google.com>
 <20230303113945.GF2420672@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303113945.GF2420672@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 11:39:45AM +0000, Lee Jones wrote:
> On Fri, 03 Mar 2023, Lee Jones wrote:
> 
> > On Mon, 13 Feb 2023, Manivannan Sadhasivam wrote:
> > 
> > > Document the commonly used LED triggers by the SoCs. Not all triggers
> > > are documented as some of them are very application specific. Most of the
> > > triggers documented here are currently used in devicetrees of many SoCs.
> > > 
> > > While at it, also place the comment above the triggers (hci, mmc, wlan)
> > > to match the rest of the binding.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > > 
> > > Changes in v6:
> > > 
> > > * Rebased on top of lee/for-leds-next branch
> > > * Fixed the comment location for few triggers
> > > 
> > > Changes in v5:
> > > 
> > > * Rebased on top of v6.2-rc1
> > > 
> > > Changes in v4:
> > > 
> > > * Removed the sorting of triggers
> > > * Removed the "items" as they were not needed
> > > * Reworded the description
> > > * Dropped Zhen Lei's tested-by tag as the patch has changed
> > > * Added kbd-capslock trigger
> > > 
> > > Changes in v3:
> > > 
> > > * Rebased on top of v6.1-rc1
> > > * Added WLAN Rx trigger
> > > * Added tested tag from Zhen Lei
> > > 
> > > Changes in v2:
> > > 
> > > * Added more triggers, fixed the regex
> > > * Sorted triggers in ascending order
> > > 
> > >  .../devicetree/bindings/leds/common.yaml      | 37 +++++++++++++++++--
> > >  1 file changed, 34 insertions(+), 3 deletions(-)
> > 
> > Applied, thanks
> 
> Change of plan.  This doesn't apply cleanly.
> 
> Could you please rebase and resubmit please?
> 

Done!

Thanks,
Mani

> -- 
> Lee Jones [李琼斯]

-- 
மணிவண்ணன் சதாசிவம்
