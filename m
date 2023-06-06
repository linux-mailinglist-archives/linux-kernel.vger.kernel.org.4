Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256F723951
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjFFHkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjFFHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:40:23 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BD11D;
        Tue,  6 Jun 2023 00:40:19 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue,  6 Jun 2023 09:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1686036768; bh=i9NO6TkKcAwCqPNK63FYEHut/QprsL1wrn2QZZ0ttOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9ANCosRO0HbiJYmvMJT0y6HG53IzA8fCKTEoUhGy6pkQJB+tDo0sOigybDbUATbs
         wAomNPoCaeB/UrDNNxNpAuoJnZyIOxpVVlhE0ouvTSD5+SPUNVmjdzDzmzFxG2wia5
         0RgSOj7smIGzjOjsZfzvl0xqSSfQQlnfUt0guVcE=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 70DA8822CB;
        Tue,  6 Jun 2023 09:32:48 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 654F7183D2F; Tue,  6 Jun 2023 09:32:48 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:32:48 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/kallsyms: constify long_options
Message-ID: <ZH7hIDQcp8pDSpwJ@buildd.core.avm.de>
References: <20230605120400.1775196-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605120400.1775196-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1686036768-4DF54F04-5900B1F2/0/0
X-purgate-type: clean
X-purgate-size: 893
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:04:00PM +0900, Masahiro Yamada wrote:
> getopt_long() does not modify this.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 0d2db41177b2..8e97ac7b38a6 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -806,7 +806,7 @@ static void record_relative_base(void)
>  int main(int argc, char **argv)
>  {
>  	while (1) {
> -		static struct option long_options[] = {
> +		static const struct option long_options[] = {
>  			{"all-symbols",     no_argument, &all_symbols,     1},
>  			{"absolute-percpu", no_argument, &absolute_percpu, 1},
>  			{"base-relative",   no_argument, &base_relative,   1},
> -- 
> 2.39.2
> 
