Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23B695995
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjBNHF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBNHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:05:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD41D921
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:05:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A611861460
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7FC433D2;
        Tue, 14 Feb 2023 07:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358324;
        bh=ca0XlNpfyEX930f/tfhIpnGlDpbWZLVAKVDtsquB1SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3pomjrRF+Fmqw1ZN08VL3aUtNVDbGQzRmuBF3MiW54iX3jp8tXZ0F4VNwteA3SGZ
         PmacFWtO96pXug2pN2YakAHyInrJU3m/8jy+yPi5+wYIvbQ1Y8D6nq5PUYweMHgEwE
         jilJ85f24P1U9S1/whLN/Ol3gcdkl43hs76QBSxo=
Date:   Tue, 14 Feb 2023 08:05:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 4/6] sign-file: cosmetic fix
Message-ID: <Y+sysOA3pV7AuYvt@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-4-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-4-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:32AM +0530, Shreenidhi Shedi wrote:
> In the previous patch for adding bulk modules support, this was not done
> because it will add a lot to review in one patch.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  scripts/sign-file.c | 174 ++++++++++++++++++++++----------------------
>  1 file changed, 87 insertions(+), 87 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 7ad330b47d64..b48832d54f45 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -395,114 +395,114 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  				replace_orig = true;
>  		}
>  
> -	/* Open the module file */
> -	bm = BIO_new_file(module_name, "rb");
> -	ERR(!bm, "%s", module_name);
> -
> -	if (!raw_sig) {
> -		/* Read the private key and the X.509 cert the PKCS#7 message
> -		 * will point to.
> -		 */
> -		private_key = read_private_key(private_key_name);
> -		x509 = read_x509(x509_name);
> -
> -		/* Digest the module data. */
> -		OpenSSL_add_all_digests();
> -		display_openssl_errors(__LINE__);
> -		digest_algo = EVP_get_digestbyname(hash_algo);
> -		ERR(!digest_algo, "EVP_get_digestbyname");
> +		/* Open the module file */
> +		bm = BIO_new_file(module_name, "rb");
> +		ERR(!bm, "%s", module_name);
> +
> +		if (!raw_sig) {
> +			/* Read the private key and the X.509 cert the PKCS#7 message
> +			 * will point to.
> +			 */
> +			private_key = read_private_key(private_key_name);
> +			x509 = read_x509(x509_name);
> +
> +			/* Digest the module data. */
> +			OpenSSL_add_all_digests();
> +			display_openssl_errors(__LINE__);
> +			digest_algo = EVP_get_digestbyname(hash_algo);
> +			ERR(!digest_algo, "EVP_get_digestbyname");
>  
>  #ifndef USE_PKCS7
> -		/* Load the signature message from the digest buffer. */
> -		cms = CMS_sign(NULL, NULL, NULL, NULL,
> -			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
> -			       CMS_DETACHED | CMS_STREAM);
> -		ERR(!cms, "CMS_sign");
> -
> -		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
> -				     CMS_NOCERTS | CMS_BINARY |
> -				     CMS_NOSMIMECAP | use_keyid |
> -				     use_signed_attrs),
> -		    "CMS_add1_signer");
> -		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
> -		    "CMS_final");
> +			/* Load the signature message from the digest buffer. */
> +			cms = CMS_sign(NULL, NULL, NULL, NULL,
> +					CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
> +					CMS_DETACHED | CMS_STREAM);
> +			ERR(!cms, "CMS_sign");
> +
> +			ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
> +						CMS_NOCERTS | CMS_BINARY |
> +						CMS_NOSMIMECAP | use_keyid |
> +						use_signed_attrs),
> +					"CMS_add1_signer");
> +			ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
> +					"CMS_final");
>  
>  #else
> -		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
> -				   PKCS7_NOCERTS | PKCS7_BINARY |
> -				   PKCS7_DETACHED | use_signed_attrs);
> -		ERR(!pkcs7, "PKCS7_sign");
> +			pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
> +					PKCS7_NOCERTS | PKCS7_BINARY |
> +					PKCS7_DETACHED | use_signed_attrs);
> +			ERR(!pkcs7, "PKCS7_sign");
>  #endif
>  
> -		if (save_sig) {
> -			char *sig_file_name;
> -			BIO *b;
> +			if (save_sig) {
> +				char *sig_file_name;
> +				BIO *b;
>  
> -			ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
> -			    "asprintf");
> -			b = BIO_new_file(sig_file_name, "wb");
> -			ERR(!b, "%s", sig_file_name);
> +				ERR(asprintf(&sig_file_name, "%s.p7s", module_name) < 0,
> +						"asprintf");
> +				b = BIO_new_file(sig_file_name, "wb");
> +				ERR(!b, "%s", sig_file_name);
>  #ifndef USE_PKCS7
> -			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> -			    "%s", sig_file_name);
> +				ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +						"%s", sig_file_name);
>  #else
> -			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> -			    "%s", sig_file_name);
> +				ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +						"%s", sig_file_name);
>  #endif
> -			BIO_free(b);
> -		}
> +				BIO_free(b);
> +			}
>  
> -		if (sign_only) {
> -			BIO_free(bm);
> -			return 0;
> +			if (sign_only) {
> +				BIO_free(bm);
> +				return 0;
> +			}
>  		}
> -	}
>  
> -	/* Open the destination file now so that we can shovel the module data
> -	 * across as we read it.
> -	 */
> -	bd = BIO_new_file(dest_name, "wb");
> -	ERR(!bd, "%s", dest_name);
> -
> -	/* Append the marker and the PKCS#7 message to the destination file */
> -	ERR(BIO_reset(bm) < 0, "%s", module_name);
> -	while ((n = BIO_read(bm, buf, sizeof(buf))),
> -	       n > 0) {
> -		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> -	}
> -	BIO_free(bm);
> -	ERR(n < 0, "%s", module_name);
> -	module_size = BIO_number_written(bd);
> +		/* Open the destination file now so that we can shovel the module data
> +		 * across as we read it.
> +		 */
> +		bd = BIO_new_file(dest_name, "wb");
> +		ERR(!bd, "%s", dest_name);
>  
> -	if (!raw_sig) {
> +		/* Append the marker and the PKCS#7 message to the destination file */
> +		ERR(BIO_reset(bm) < 0, "%s", module_name);
> +		while ((n = BIO_read(bm, buf, sizeof(buf))),
> +				n > 0) {
> +			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> +		}
> +		BIO_free(bm);
> +		ERR(n < 0, "%s", module_name);
> +		module_size = BIO_number_written(bd);
> +
> +		if (!raw_sig) {
>  #ifndef USE_PKCS7
> -		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
> +			ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
>  #else
> -		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +			ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
>  #endif
> -	} else {
> -		BIO *b;
> +		} else {
> +			BIO *b;
>  
> -		/* Read the raw signature file and write the data to the
> -		 * destination file
> -		 */
> -		b = BIO_new_file(raw_sig_name, "rb");
> -		ERR(!b, "%s", raw_sig_name);
> -		while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
> -			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> -		BIO_free(b);
> -	}
> +			/* Read the raw signature file and write the data to the
> +			 * destination file
> +			 */
> +			b = BIO_new_file(raw_sig_name, "rb");
> +			ERR(!b, "%s", raw_sig_name);
> +			while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
> +				ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> +			BIO_free(b);
> +		}
>  
> -	sig_size = BIO_number_written(bd) - module_size;
> -	sig_info.sig_len = htonl(sig_size);
> -	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
> -	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
> +		sig_size = BIO_number_written(bd) - module_size;
> +		sig_info.sig_len = htonl(sig_size);
> +		ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
> +		ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
>  
> -	ERR(BIO_free(bd) < 0, "%s", dest_name);
> +		ERR(BIO_free(bd) < 0, "%s", dest_name);
>  
> -	/* Finally, if we're signing in place, replace the original. */
> -	if (replace_orig)
> -		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
> +		/* Finally, if we're signing in place, replace the original. */
> +		if (replace_orig)
> +			ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
>  	}
>  
>  	return 0;
> -- 
> 2.39.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
