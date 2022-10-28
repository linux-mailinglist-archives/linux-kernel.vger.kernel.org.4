Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5CC61128C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJ1NWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1NWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:22:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F51CFF0C;
        Fri, 28 Oct 2022 06:22:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so4451440pjl.3;
        Fri, 28 Oct 2022 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VeWGKF4TGD3lkXCy7KOGfqWrqbXf9JPzgRUKOeBorU=;
        b=aWYfJlPCUpZhXaZUIoKmWDvGG6NHgssOvzY2kaj+coN35LSoiMWMOnah4dFWMK41In
         hkQI1ntF1CAZRJyAtU0RORMxmuJtt0KiO0MFgj0TInwpENyJd9FGsBNUfn8S50/t0rBV
         lPbcIwWoeOh28lAU+TV/XTI8bGmkhNi8Chw9vB20EniujJZ9OZQINquDxM0KGwYMzS7d
         tjgxB874WOvOmg2qJPp3RJ828KtR2Kp9bieqDax7+gJZDrIJsRojCmhlmI6nbc0UZ3Vc
         NWDEdZSqYDr00X7ftoFFpHDUd4ifotOe7jx8eYnt7GxDHfyfm8d2EvEVgRxVtOW9rTRf
         pFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VeWGKF4TGD3lkXCy7KOGfqWrqbXf9JPzgRUKOeBorU=;
        b=ieVaUZF33fy75m7x432y6bKmhchRSq4iL0iZgMD02DK+lfSmpyHjTAwrY3IV+2P/NE
         dPTkuSD+9PVAv1lVAUMDOU8MhIC09XMXSX0rz91qsxyOQcvbna8l/JyJzb8pHbkDsnoY
         u9SauWf631bNfSkR3Ab2oDnBLp764aifH5QbigKc9aplysibl9+DtjPLFz6Npm99aJRd
         CfGeyr7yDz+1FIlqvVletIdp5ZkkyRsms7MvTXs6J5TUP5KzH1OzdjbuOpxUOed2dZSO
         wjwRBST5ZKYROQNZEG+DknUGdNhnTfrCAyxFB5f7u/9HkiMIr/mjajBFQkjcFC0aD0uT
         PT5A==
X-Gm-Message-State: ACrzQf3ipz+cLVG7gZVYBO3DB8GP9YZPqI0fwG6Jf5Z6nsUnWmuXqXOy
        AVgN9sPJoxqt43WnpNCjuq8=
X-Google-Smtp-Source: AMsMyM4idkCtNPIHOnwfs0Ot6DujO796ASuOs4KqeFAIwEt+t8L8TeDFTtXVJCawiMVrPG3fwli8fA==
X-Received: by 2002:a17:902:a5c9:b0:182:3c47:6e86 with SMTP id t9-20020a170902a5c900b001823c476e86mr54264396plq.152.1666963322603;
        Fri, 28 Oct 2022 06:22:02 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b00187033cac81sm158695plb.145.2022.10.28.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:22:02 -0700 (PDT)
Message-ID: <9d96c96d-dfc7-7749-07d4-2601c00661c2@gmail.com>
Date:   Fri, 28 Oct 2022 20:21:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 03/15] pcmcia: synclink_cs: remove MGSLPC_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <c909c36218b0d4b5888b41f9af18e763a5b36dcf.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <c909c36218b0d4b5888b41f9af18e763a5b36dcf.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:42, наб wrote:
> This is 100% dead cruft, and we have better debugging tooling nowadays:
> kill it
> 

Again, same reply as [1].

Also, ask yourself: what are better ways to do debugging kernel (including
tools) than relying to magic numbers?

Thanks.

[1]: https://lore.kernel.org/linux-doc/47c2bffb-6bfe-7f5d-0d2d-3cbb99d31019@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

