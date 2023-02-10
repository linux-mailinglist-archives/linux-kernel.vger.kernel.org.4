Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF7691766
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBJDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBJDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:55:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECF6F21D;
        Thu,  9 Feb 2023 19:55:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA1EC61C52;
        Fri, 10 Feb 2023 03:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2096C433D2;
        Fri, 10 Feb 2023 03:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676001304;
        bh=hTbI/uHdUcdMjp23oy6AQJPVhQQNne0zOy2ZW7ePXC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Agvr9H4m49pgl8YBrcMH6JTmlLGPM1q6eIzkVzHIi9Zl5bDjnXoYbCXv5ACgxSrXA
         Q1dhGT6jhe0LnMMCg4/A4KUvBX7lSkLFi+f3W1V6d5YrV77PLRqhuHV1hEsvg9m3wS
         AlIEZGtYtIzQWPBQ4RVPBRLI5T4JySNqA0xB2WpERxyY41D7D/R/ejCrRmBLb1huo2
         2l0aZiP7tSChFa9uNQphsh5EbeuoRl15JtFo+FqyJ+L793qWZUBubaGaqdBkQdc6+K
         HPr8akQGAcXRdS2p2qBL5+31FQQH9vxtLhe1vDYajnzZjJPVUjWuAgi5/fd7v0b0/N
         cTh6jpc5heu3A==
Date:   Fri, 10 Feb 2023 05:55:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 17/24] Documentation: security: correct spelling
Message-ID: <Y+XAFZzp8zY8fLzT@kernel.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
 <20230209071400.31476-18-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209071400.31476-18-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:13:53PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/security/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: keyrings@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  Documentation/security/digsig.rst       |    4 ++--
>  Documentation/security/keys/core.rst    |    2 +-
>  Documentation/security/secrets/coco.rst |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff -- a/Documentation/security/digsig.rst b/Documentation/security/digsig.rst
> --- a/Documentation/security/digsig.rst
> +++ b/Documentation/security/digsig.rst
> @@ -62,7 +62,7 @@ API currently includes only 1 function::
>  	* digsig_verify() - digital signature verification with public key
>  	* @keyring:	keyring to search key in
>  	* @sig:	digital signature
> -	* @sigen:	length of the signature
> +	* @siglen:	length of the signature
>  	* @data:	data
>  	* @datalen:	length of the data
>  	* @return:	0 on success, -EINVAL otherwise
> @@ -82,7 +82,7 @@ The signing and key management utilities
>  to generate signatures, to load keys into the kernel keyring.
>  Keys can be in PEM or converted to the kernel format.
>  When the key is added to the kernel keyring, the keyid defines the name
> -of the key: 5D2B05FC633EE3E8 in the example bellow.
> +of the key: 5D2B05FC633EE3E8 in the example below.
>  
>  Here is example output of the keyctl utility::
>  
> diff -- a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -869,7 +869,7 @@ The keyctl syscall functions are:
>  
>  	 - ``char *hashname`` specifies the NUL terminated string identifying
>  	   the hash used from the kernel crypto API and applied for the KDF
> -	   operation. The KDF implemenation complies with SP800-56A as well
> +	   operation. The KDF implementation complies with SP800-56A as well
>  	   as with SP800-108 (the counter KDF).
>  
>  	 - ``char *otherinfo`` specifies the OtherInfo data as documented in
> diff -- a/Documentation/security/secrets/coco.rst b/Documentation/security/secrets/coco.rst
> --- a/Documentation/security/secrets/coco.rst
> +++ b/Documentation/security/secrets/coco.rst
> @@ -34,7 +34,7 @@ be use it for its own purposes.
>  
>  During the VM's launch, the virtual machine manager may inject a secret to that
>  area.  In AMD SEV and SEV-ES this is performed using the
> -``KVM_SEV_LAUNCH_SECRET`` command (see [sev]_).  The strucutre of the injected
> +``KVM_SEV_LAUNCH_SECRET`` command (see [sev]_).  The structure of the injected
>  Guest Owner secret data should be a GUIDed table of secret values; the binary
>  format is described in ``drivers/virt/coco/efi_secret/efi_secret.c`` under
>  "Structure of the EFI secret area".

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
