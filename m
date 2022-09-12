Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447715B58F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiILLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:03:03 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D9220CC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:03:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 8A0072012C;
        Mon, 12 Sep 2022 13:03:00 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yh6EehX2MSYf; Mon, 12 Sep 2022 13:03:00 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 32C0120127;
        Mon, 12 Sep 2022 13:02:59 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oXhDO-008y6m-1O;
        Mon, 12 Sep 2022 13:02:58 +0200
Date:   Mon, 12 Sep 2022 13:02:58 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     cgel.zte@gmail.com
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        Cspeakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] speakup/utils: use "!P" instead of "P == 0"
Message-ID: <20220912110258.jwyv4xenfdvmo3p3@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        cgel.zte@gmail.com, w.d.hubbs@gmail.com, chris@the-brannons.com,
        kirk@reisers.ca, Cspeakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220912102059.18215-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912102059.18215-1-xu.panda@zte.com.cn>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com, le lun. 12 sept. 2022 10:21:00 +0000, a ecrit:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> comparing pointer to 0, use !P instead of it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/utils.h b/drivers/accessibility/speakup/utils.h
> index 4bf2ee8ac246..58ca9847637f 100644
> --- a/drivers/accessibility/speakup/utils.h
> +++ b/drivers/accessibility/speakup/utils.h
> @@ -36,7 +36,7 @@ static inline void open_input(const char *dir_name, const char *name)
>         else
>                 snprintf(filename, sizeof(filename), "%s", name);
>         infile = fopen(filename, "r");
> -       if (infile == 0) {
> +       if (!infile) {
>                 fprintf(stderr, "can't open %s\n", filename);
>                 exit(1);
>         }
> -- 
> 2.15.2
> 
