Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D123B68AD82
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBDXqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjBDXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:46:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE23F1F5CB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:46:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lu11so24941788ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SU4sr6Rv4JHucUmKgKWNj4LgU27LyAb+SvnHwp1wjd4=;
        b=V5kpmwW+rSp1Sjx5X9cmrwhFbSO45xrFyDqi5LgSXI+RAC+0JJ2Sg1u180Nx+lslcE
         br9tsNInhbPx8HjYjKWw+cYoAIAKgDGFQU3sGlSqcyCVi00OF61/f+vwTc9afcWOM08U
         N7V/rHRH06P23VMNsJN3Ezjjf2UhH2ZMMJKwWDrqJf+o3o8DULRKOP9WYiCI69Btg1Mu
         Mf12965sbE9rJY2PcH4JzW97OkYHH1bnvAYUQROCB5lXKwgx0BkwvgRgmL3XgA/bUiDO
         5wqRVqHigILDdsPQi1v0Zw1vI1rqAO9M5+x2whXJjtadJv+Mt6dQRWD/NtLIGiM782Yy
         l0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU4sr6Rv4JHucUmKgKWNj4LgU27LyAb+SvnHwp1wjd4=;
        b=odSBZUFT74TDE4KzYqtN04F9xgwuxSt5dj546Fo11OY/F8SwTLX44vUo0rpqJ0K+pM
         VvBHxoihPSbL5Zg6olH+4ECyWAevt2IO2gMn9mPdaajTg+1OxWe2ihWCzqM2SAUTVZZh
         8q/VeMHfr4NBbfypp2rleJioxSvHaesqvpt2HWleWpciJ3vngVqijRerkowOO1+B+ULr
         DSMtGpjt8y6nTGBhinOp0nIjmYzlMplIb6pQCp/L78L1bgKvZAJnnkf3B57g004rh26s
         cQAazKQiUaLsKuGfh6ZTx3GR0O93AbsN/Fej1DPZw+MVt53oL8m8k3WSKggn443Kdp8q
         X2gQ==
X-Gm-Message-State: AO0yUKVf+yFt786VzCJ3DT/MiCNGpDu2o+cyYfIihrwa4jeFja0XLhmF
        0Vvsd4Ar7vpv3fxig4V1RWW23VGjKVI=
X-Google-Smtp-Source: AK7set/mu5BHwC+20dHoMIeyFfe1BxAb06FRLKjRkUAs8EQ7fr2uhQO6lLYWg7qn8mkJBuP7S2kHCQ==
X-Received: by 2002:a17:907:72c1:b0:871:178d:fc1e with SMTP id du1-20020a17090772c100b00871178dfc1emr18460669ejc.77.1675554388139;
        Sat, 04 Feb 2023 15:46:28 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id me17-20020a170906aed100b0083f91a32131sm3414516ejb.0.2023.02.04.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 15:46:27 -0800 (PST)
Date:   Sun, 5 Feb 2023 00:46:25 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Regarding checkpatch camelcase issues
Message-ID: <Y97uUeB6OfO469SY@combine-ThinkPad-S1-Yoga>
References: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
 <Y94L+WNGGfvrg6Mg@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y94L+WNGGfvrg6Mg@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:40:41PM +0700, Bagas Sanjaya wrote:
> On Sat, Feb 04, 2023 at 05:25:38AM +0100, Guru Mehar Rachaputi wrote:
> > Thanks for your support.
> > 
> > I wanted to confirm if each checkpatch encounter for camelcase issue should
> > be fixed in a new patch?
> > 
> > For example: If the issue is with same variable, then multiple
> > modifications can be made in one patch.
> > 
> >   -> above example is OK
> > 
> > 
> > For example: If the issue is with multiple variables, then multiple
> > modifications can be made in one patch.
> > 
> >   -> above example is NOT OK / NG
> > 
> > 
> > Please confirm me if my understanding is correct?
> > 
> 
> I guess you have generated a patch series, then check it through
> checkpatch.
> 
> Indeed, if checkpatch complains at a particular patch, you need to do
> interactive rebase. Make sure that rebase todo list contains "edit"
> lines on commit you want to fix up. After that, fix these complaints.
> 
> When you're done, regenerate the patch series and make sure that there
> are no checkpatch complains on it.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Thanks for the reply
I guess I was not clear. When I run checkpatch on a driver there
were so many camelcase issues in each file. So I wanted to know if I
proceed to fix them, should I submit each change as a patch or each file
as a patch?
Since each file has many camelcase issue and the driver has morethan one
such file.

-- 
Thanks & Regards,
Guru
