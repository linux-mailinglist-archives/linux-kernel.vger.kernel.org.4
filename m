Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569874DEAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGJUBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGJUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:01:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C513E;
        Mon, 10 Jul 2023 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=NARVxAHU8hdSWaaKOBo8T6Vk6x7Y5zqJLlil7BmYBVI=; b=cqIo0WmUCiJcN5pvSBP2FkMxKH
        k2ZnLOmwNaJJPJkw4PW+4V3p2f4rePzcvXzUNSG9s+9OInLdffZVlrx4tymeLgq9+VbRSOhSDl6XV
        4gtgUmlPmRQG54ZE3p97WtRvFk/wCSzluiK4GvAwWodn6Amlah7IDZlamtPctaEDuMOEi3MDQ62hy
        2YpdSsn6d3WpLq9OkhK4ACN/DAvHvtIMgQgXllsRX8VX658Y5w/AEMGXljrHpWRgFPQ5hYAm2uKID
        lCk+W3XQOdHKr9dRwzvFmdojjV2R6D87JreCthNUssxalzqdYYxQv1yDjNSd2VvteMN1Zkqp43zkS
        AdjdKvfQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIx47-00CcDE-1R;
        Mon, 10 Jul 2023 20:00:59 +0000
Message-ID: <fa1d9a4c-16fe-955d-071b-d39f1a0d9b58@infradead.org>
Date:   Mon, 10 Jul 2023 13:00:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/13] Update MAINTAINERS file.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-2-greg@enjellic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710102319.19716-2-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/10/23 03:23, Dr. Greg wrote:
> Add an entry to the MAINTAINERS file to document the maintainer's
> address and files relevant to the Trusted Security Event Modeling
> system (TSEM).
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35e19594640d..4660c972d5e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19026,6 +19026,14 @@ F:	include/uapi/linux/selinux_netlink.h
>  F:	scripts/selinux/
>  F:	security/selinux/
>  
> +TSEM SECURITY MODULE
> +M:	Greg Wettstein <greg@enjellic.com>
> +S:	Maintained
> +L:	linux-security-module@vger.kernel.org
> +F:	Documentation/admin-guide/LSM/tsem.rst
> +F:	Documentation/ABI/testing/tsemfs
> +F:	security/tsem/
> +

Please insert entries in the MAINTAINERS file in alphabetical order
(as stated in that file).

Thanks.

>  SENSABLE PHANTOM
>  M:	Jiri Slaby <jirislaby@kernel.org>
>  S:	Maintained

-- 
~Randy
