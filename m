Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8F618FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDF2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDF2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:28:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A96B17078
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:28:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p21so3932113plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 22:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZA/RVayZ3xPzTcijc9xreYUpwXHdEjEcBaYNiEBe2w=;
        b=uGtGtq6UnyJR/jkkWscar8jyw73oiXSdxk3hWQF0TF3JLCC2yng0atFxpBJE+AiHkV
         7BwNBcKDBrV1HMnq6ryIXpG4LQE6qNPilaqHBPjqQF9P9EXT0KGXWnYwEe498qKVc3Om
         Vxzi/0G7wvv0QwshG0wsletJH957EuWfRJgbxmyukTjMj03ClZnYXMnkM6OpnxqHVEbl
         cqtHja6gQemx8PoV/WJM1jTqGdFmSAnpxHlKumaYlu/y2TDPYl9R2a6vlqmO6xSzY6P7
         aYUKt1ShATG2pvlcS/pHNBJImRel3NE3lITcMEzLHSayvjN+X2w0L6HUs6HlX5zDaraZ
         rwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZA/RVayZ3xPzTcijc9xreYUpwXHdEjEcBaYNiEBe2w=;
        b=JkkUujdVbo14dbyeNXooXBr+Y1itNcMel5xmfOFA+qOjtb9F3vjkHgKjuYLE32e5Tb
         P83MUHF9aiDFp4pXo0cIgGAOCkBg+hpLZPGdvKwIIqi8+2oPKoZlM9z7Qs4DJ81Heogk
         62WUXhAf6cyMDtL7C1kmvMkY3N9/KhK+sBix3o1Tf86e0slaHgIvxYAxNGlVnIgmm/On
         QvCmvLmbsGxFVpBGTIVJeAmFkJItjfLZZjvbL+LUPOiU4r2nkyey/BUUCZbzcCvVSKtw
         f30qgyrxv6Cux1ehbw0LiO+UU9SGsfkaTC4e3pO2yqEXmsxKt9QM742QhmGC4YS71jC5
         5lJg==
X-Gm-Message-State: ACrzQf0af5n6Pzb+AtyNEFdAdP2nQOVUqpxPaC+0r+rUN+FLHl6pj3XQ
        j0KfcD+Wbm+5oreLMeCwqHYq5A==
X-Google-Smtp-Source: AMsMyM66RRa5hHdEci2sgowcXAvY4FXvutVFcYNi00yIFLuY38qpZu4IRAvZMe8bNb0luDlIHV7f/A==
X-Received: by 2002:a17:902:cecf:b0:187:fd2:79c3 with SMTP id d15-20020a170902cecf00b001870fd279c3mr17242552plg.34.1667539709985;
        Thu, 03 Nov 2022 22:28:29 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902c64b00b00186c3727294sm1525909pls.270.2022.11.03.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:28:29 -0700 (PDT)
Date:   Fri, 4 Nov 2022 10:58:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, vincent.guittot@linaro.org,
        vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in
 opp_parse_supplies()
Message-ID: <20221104052826.umvk6gxm6nus2oqv@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
 <2379445.NG923GbCHz@makoto>
 <20221104050752.67eh54ui2ohbbyni@vireshk-i7>
 <2209158.NgBsaNRSFp@makoto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2209158.NgBsaNRSFp@makoto>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-22, 15:25, James Calligeros wrote:
> On Friday, 4 November 2022 3:07:52 PM AEST Viresh Kumar wrote:
> > It should happen sequentially.
> 
>  I noticed the mutexes after I got some sleep :)
> 
> > Initialize "ret = 0" in opp_parse_supplies().
> > 
> > Or pick patches from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> > 
> 
> It didn't even cross my mind that opp_parse_supplies() returning
> ret uninitialised was causing the failure further up the chain. Applied
> and tested, everything's working as expected now. 
> 
> > Sorry for the trouble.
> 
> This is on me, I should have heeded the compiler warning.

Thanks James for giving this a try. Really appreciate it. The changes are
applied and pushed for linux-next along with your Tested-by.

-- 
viresh
