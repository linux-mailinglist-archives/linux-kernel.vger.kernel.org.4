Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6A7215F3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjFDKFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFDKFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:05:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD9DB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 03:05:30 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5kc3qnMr98aX95kc3ql4Ju; Sun, 04 Jun 2023 12:05:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685873128;
        bh=H7HOt9NbS9hKvkpvzL9bUevl/qXMy7TlMlUd9qZbZuQ=;
        h=Date:Subject:Cc:References:From:In-Reply-To;
        b=Suudwoo4DermxkyYPVUrf3YfDmlOejnxQebkESIISRpAfn0plY6b5kC02rmkIVeft
         7inNz4P0lYD+GPHg/McD0mmlmThuL+pTA/+Zipz+kb+YVUelA5eNrgqz4hcpwU0r5I
         7G3dYt1Dt6oTOSobmI6jsTEHJaWVC8nV8hUHGVdyR5xtc3exylCgGz6a0DYIaz3YUe
         RNMbrpMcdOmQMQLsfy319v6aE+H1JmrZ03N5kfyOkNtxVAs7Duiw4/hkHFyEf6h0BJ
         EI9x3UIJZRxIkmNZ56/5DXXMiz0Ez8RA6RXxcHtcqHZkvkZyrsL0la9VmCK1rmyagL
         AT/s6yn0GQGYA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 12:05:28 +0200
X-ME-IP: 86.243.2.178
Message-ID: <48ecec64-5e9f-8081-753b-f2c6f188980c@wanadoo.fr>
Date:   Sun, 4 Jun 2023 12:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cdx: Drop useless LIST_HEAD
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <cee692c7babd754c1c36186af116c4bb4dad0a17.1685853842.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/06/2023 à 06:44, Christophe JAILLET a écrit :
> 'cleanup_list' is unused, so drop it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/cdx/controller/mcdi.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
> index a211a2ca762e..03e34f214aea 100644
> --- a/drivers/cdx/controller/mcdi.c
> +++ b/drivers/cdx/controller/mcdi.c
> @@ -611,7 +611,6 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
>   {
>   	struct cdx_mcdi_iface *mcdi;
>   	struct cdx_mcdi_cmd *cmd;
> -	LIST_HEAD(cleanup_list);
>   	unsigned int respseq;
>   
>   	if (!len || !outbuf) {


NAK. Ouch!

Something went wrong in my compile-testing process for this one, sorry 
for the noise.


CJ

