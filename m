Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9B6666EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjAKXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAKXDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:03:39 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C53B3;
        Wed, 11 Jan 2023 15:03:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2E78C5BF;
        Wed, 11 Jan 2023 23:03:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E78C5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673478218; bh=3wvR3ghwG9vXgGDkNCHmXYTndStJtbNs9Aa2tpCjsxA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UGTfZt68oRaqfDd/C6//1P+MdxaUTJ+XIfmZ63BoqVs6HaiEwAN9PhoJYHrtCtnu5
         fTcEB317gcRSB484hGzO+ukRVm8cLYlTPu2+qGiw7j5L5B9C+MdRDbRFCRhgoqyrhx
         ZYd86tq3c+1Itp/le5FDx/Nj5WgVgn3qlwkdvwnD4Z5HSPoPAOVWfOQZltZ6cAgEZc
         zUpMSdw9/wuOCzO8U5eLgQpbbrGz/beUE5uciDtqIHziRNw2SMyW5Dd1ZmVEJv6JPw
         9P1d8ddaxup5p2XtFMs9uCIM8nVcaI4q+uKZqI3Zz0MiwMz9mpmd7s42Da6347QoZD
         cf8ZZhFIkYjiw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: add translation for botching-up-ioctl.rst
In-Reply-To: <20230102183716.9698-1-federico.vaga@vaga.pv.it>
References: <20230102183716.9698-1-federico.vaga@vaga.pv.it>
Date:   Wed, 11 Jan 2023 16:03:37 -0700
Message-ID: <87zgaovfli.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> This patch adds the translation for the botching up ioctl document.
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
> V1 -> V2 use the kernel-doc mecanism to link functions in documents
>
>  .../it_IT/process/botching-up-ioctls.rst      | 249 ++++++++++++++++++
>  .../translations/it_IT/process/index.rst      |   1 +
>  2 files changed, 250 insertions(+)
>  create mode 100644 Documentation/translations/it_IT/process/botching-up-ioctls.rst

I've applied this, but I have to ask:

> diff --git a/Documentation/translations/it_IT/process/botching-up-ioctls.rst b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
> new file mode 100644
> index 000000000000..91732cdf808a
> --- /dev/null
> +++ b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
> @@ -0,0 +1,249 @@
> +.. include:: ../disclaimer-ita.rst
> +
> +:Original: Documentation/process/botching-up-ioctls.rst
> +
> +==========================================
> +(Come evitare di) Raffazzonare delle ioctl
> +==========================================

Is "raffazzonare" the right verb here?  Something like "pasticciare"
seems closer to me, but I'm not the expert here.

Thanks,

jon
