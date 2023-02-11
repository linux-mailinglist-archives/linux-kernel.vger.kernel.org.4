Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5A693354
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBKTeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBKTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:34:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9A13D5A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:34:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so7335581pjk.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3Js8zzahWer/PYT8ZpjGhI4eILqJDG8MMD1Qe5psuI=;
        b=YWdBd0AsjRMZL7FdsOSzNn2DzdNeVlr36hq4aE8IEiRXEoebT8prxSBbjt3uSjtafA
         0xKVF32rqVhQ2npqtA+NnPKSr5U2akCaBBt1ngBbWH4dZ638Ff4hkkLrHGqxMA272lIZ
         T1rPOzJcyCq6XSq2czKG9UN+WzjVpXIb/wpQhHwmMOQY+/MKNndRgUr0MgL3lzrf/SsY
         wueXII44pNEYh1sd+XezfluGq1BqIUQwkVaak1eeR33esLKU/F+uxBSUpluZEId4dNk4
         3cDoP6F6nkkmQX5tHAbkPFHLCIAx6pe6PAeEHR5m7O+9QyDXfY8T1r3TOqXgH7V9tCeN
         MCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Js8zzahWer/PYT8ZpjGhI4eILqJDG8MMD1Qe5psuI=;
        b=nXeA7N3Bv4AEg32dTEUUYw90AndRRQrDGdDNBTi3QHcjCam1iS0V+zJ/5GEhf2+3lp
         sU/2vh74WohnDliI4/90eQ/4OD8mt1V6uK5d607l+uWEbQkzOgSufCUHQVfus74OgYar
         xCWo7jSsKPkaiJ4pzUKePMo29jIYypY7JKFNV0q5GR5q08NhMBfOil4quR8NgLmOKEls
         wPp7fJbyoeCK2bvn+W3E7C7xFrQ8THdVAHPk4nliza+trFKD9IlmDx93lG78jHQR4g40
         qawKVS5HFj3KvkpmTX0Vo18UeJKsdGsYWInCs5uRFVDQm2EvUDvsxthC2fZPCl07UC1w
         S5IA==
X-Gm-Message-State: AO0yUKVFePgluRcyUdo3+nZqhk3HY/xaJ6iec+/8jCPnU2/q9SAJPiro
        frbT1Y8x3oIScDDMc6Yephg=
X-Google-Smtp-Source: AK7set//t6DGrsvMQJlQZe+BZn1TMah+sCWDBpR5ul4yauZ9EosSzW3j93M+uwGEogAKO/sGkJWHPA==
X-Received: by 2002:a17:902:ecc2:b0:19a:968d:26f9 with SMTP id a2-20020a170902ecc200b0019a968d26f9mr376720plh.54.1676144053033;
        Sat, 11 Feb 2023 11:34:13 -0800 (PST)
Received: from [192.168.0.103] ([106.51.242.165])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b00198f73f9d54sm3073264plz.117.2023.02.11.11.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 11:34:12 -0800 (PST)
Message-ID: <dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com>
Date:   Sun, 12 Feb 2023 01:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/4] sign-file: refactor argument parsing logic
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
References: <20230209160523.858502-1-sshedi@vmware.com>
In-Reply-To: <20230209160523.858502-1-sshedi@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9-Feb-2023 21:35, Shreenidhi Shedi wrote:
> Add support for bulk signing of modules.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>   sign-file.c | 349 ++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 228 insertions(+), 121 deletions(-)
> 
> diff --git a/sign-file.c b/sign-file.c
> index 598ef54..76fee75 100644
> --- a/sign-file.c
> +++ b/sign-file.c
> @@ -213,15 +213,117 @@ static X509 *read_x509(const char *x509_name)
>   	return x509;
>   }
> 
> +struct cmd_opts {
> +	char *hash_algo;
> +	char *dest_name;
> +	char *private_key_name;
> +	char *raw_sig_name;
> +	char *x509_name;
> +	char *module_name;
> +	bool save_sig;
> +	bool replace_orig;
> +	bool raw_sig;
> +	bool sign_only;
> +	bool bulk_sign;
> +
> +#ifndef USE_PKCS7
> +	unsigned int use_keyid;
> +#endif
> +};
> +
> +void parse_args(int *argc, char **argv, struct cmd_opts *opts)
> +{
> +	struct option cmd_options[] = {
> +		/* These options set a flag. */
> +		{"help", no_argument, 0, 'h'},
> +		{"savesig", no_argument, 0, 's'},
> +		{"signonly", no_argument, 0, 'o'},
> +		{"bulksign", no_argument, 0, 'b'},
> +#ifndef USE_PKCS7
> +		{"usekeyid", no_argument, 0, 'k'},
> +#endif
> +		{"rawsig", required_argument, 0, 'r'},
> +		{"privkey", required_argument, 0, 'p'},
> +		{"hashalgo", required_argument, 0, 'a'},
> +		{"x509", required_argument, 0, 'x'},
> +		{"dest", required_argument, 0, 'd'},
> +		{"replaceorig", required_argument, 0, 'l'},
> +		{0, 0, 0, 0}
> +	};
> +
> +	int opt;
> +	int opt_index;
> +
> +	do {
> +#ifndef USE_PKCS7
> +		opt = getopt_long_only(*argc, argv, "hsobr:p:a:x:d:l:",
> +					cmd_options, &opt_index);
> +#else
> +		opt = getopt_long_only(*argc, argv, "hsobkr:p:a:x:d:l:",
> +					cmd_options, &opt_index);
> +#endif
> +		switch (opt) {
> +		case 'h':
> +			format();
> +			break;
> +
> +		case 'r':
> +			opts->raw_sig = true;
> +			opts->raw_sig_name = optarg;
> +			break;
> +
> +		case 's':
> +			opts->save_sig = true;
> +			break;
> +
> +		case 'o':
> +			opts->sign_only = true;
> +			opts->save_sig = true;
> +			break;
> +
> +#ifndef USE_PKCS7
> +		case 'k':
> +			opts->use_keyid = CMS_USE_KEYID;
> +			break;
> +#endif
> +
> +		case 'p':
> +			opts->private_key_name = optarg;
> +			break;
> +
> +		case 'a':
> +			opts->hash_algo = optarg;
> +			break;
> +
> +		case 'x':
> +			opts->x509_name = optarg;
> +			break;
> +
> +		case 'd':
> +			opts->dest_name = optarg;
> +			break;
> +
> +		case 'l':
> +			opts->replace_orig = true;
> +			break;
> +
> +		case 'b':
> +			opts->bulk_sign = true;
> +			break;
> +
> +		case -1:
> +			break;
> +
> +		default:
> +			format();
> +			break;
> +		}
> +	} while (opt != -1);
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
> -	char *hash_algo = NULL;
> -	char *private_key_name = NULL, *raw_sig_name = NULL;
> -	char *x509_name, *module_name, *dest_name;
> -	bool save_sig = false, replace_orig;
> -	bool sign_only = false;
> -	bool raw_sig = false;
>   	unsigned char buf[4096];
>   	unsigned long module_size, sig_size;
>   	unsigned int use_signed_attrs;
> @@ -229,13 +331,14 @@ int main(int argc, char **argv)
>   	EVP_PKEY *private_key;
>   #ifndef USE_PKCS7
>   	CMS_ContentInfo *cms = NULL;
> -	unsigned int use_keyid = 0;
>   #else
>   	PKCS7 *pkcs7 = NULL;
>   #endif
>   	X509 *x509;
>   	BIO *bd, *bm;
> -	int opt, n;
> +	int i, n;
> +	struct cmd_opts opts = {0};
> +
>   	OpenSSL_add_all_algorithms();
>   	ERR_load_crypto_strings();
>   	ERR_clear_error();
> @@ -248,159 +351,163 @@ int main(int argc, char **argv)
>   	use_signed_attrs = PKCS7_NOATTR;
>   #endif
> 
> -	do {
> -		opt = getopt(argc, argv, "sdpk");
> -		switch (opt) {
> -		case 's': raw_sig = true; break;
> -		case 'p': save_sig = true; break;
> -		case 'd': sign_only = true; save_sig = true; break;
> +	parse_args(&argc, argv, &opts);
> +	argc -= optind;
> +	argv += optind;
> +
> +	char *hash_algo = opts.hash_algo;
> +	char *dest_name = opts.dest_name;
> +	char *private_key_name = opts.private_key_name;
> +	char *raw_sig_name = opts.raw_sig_name;
> +	char *x509_name = opts.x509_name;
> +	char *module_name = opts.module_name;
> +	bool save_sig = opts.save_sig;
> +	bool replace_orig = opts.replace_orig;
> +	bool raw_sig = opts.raw_sig;
> +	bool sign_only = opts.sign_only;
> +	bool bulk_sign = opts.bulk_sign;
> +
>   #ifndef USE_PKCS7
> -		case 'k': use_keyid = CMS_USE_KEYID; break;
> +	unsigned int use_keyid = opts.bulk_sign;
>   #endif
> -		case -1: break;
> -		default: format();
> -		}
> -	} while (opt != -1);
> 
> -	argc -= optind;
> -	argv += optind;
> -	if (argc < 4 || argc > 5)
> +	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
>   		format();
> 
> -	if (raw_sig) {
> -		raw_sig_name = argv[0];
> -		hash_algo = argv[1];
> -	} else {
> -		hash_algo = argv[0];
> -		private_key_name = argv[1];
> -	}
> -	x509_name = argv[2];
> -	module_name = argv[3];
> -	if (argc == 5 && strcmp(argv[3], argv[4]) != 0) {
> -		dest_name = argv[4];
> +	if (dest_name && strcmp(argv[0], dest_name)) {
>   		replace_orig = false;
>   	} else {
>   		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
> -		    "asprintf");
> +				"asprintf");
>   		replace_orig = true;
>   	}
> 
>   #ifdef USE_PKCS7
>   	if (strcmp(hash_algo, "sha1") != 0) {
>   		fprintf(stderr, "sign-file: %s only supports SHA1 signing\n",
> -			OPENSSL_VERSION_TEXT);
> +				OPENSSL_VERSION_TEXT);
>   		exit(3);
>   	}
>   #endif
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
> +	for (i = 0; i < argc; i++) {
> +		module_name = argv[i];
> 
> -		/* Digest the module data. */
> -		OpenSSL_add_all_digests();
> -		display_openssl_errors(__LINE__);
> -		digest_algo = EVP_get_digestbyname(hash_algo);
> -		ERR(!digest_algo, "EVP_get_digestbyname");
> +		if (bulk_sign) {
> +			ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
> +					"asprintf");
> +			if (!replace_orig)
> +				replace_orig = true;
> +		}
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
>   #ifndef USE_PKCS7
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
>   #else
> -		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
> -				   PKCS7_NOCERTS | PKCS7_BINARY |
> -				   PKCS7_DETACHED | use_signed_attrs);
> -		ERR(!pkcs7, "PKCS7_sign");
> +			pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
> +					PKCS7_NOCERTS | PKCS7_BINARY |
> +					PKCS7_DETACHED | use_signed_attrs);
> +			ERR(!pkcs7, "PKCS7_sign");
>   #endif
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
>   #ifndef USE_PKCS7
> -			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> -			    "%s", sig_file_name);
> +				ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +						"%s", sig_file_name);
>   #else
> -			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> -			    "%s", sig_file_name);
> +				ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +						"%s", sig_file_name);
>   #endif
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
>   		}
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
> +
> +		/* Append the marker and the PKCS#7 message to the destination file */
> +		ERR(BIO_reset(bm) < 0, "%s", module_name);
> +		while ((n = BIO_read(bm, buf, sizeof(buf))),
> +				n > 0) {
> +			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> +		}
> +		BIO_free(bm);
> +		ERR(n < 0, "%s", module_name);
> +		module_size = BIO_number_written(bd);
> 
> -	if (!raw_sig) {
> +		if (!raw_sig) {
>   #ifndef USE_PKCS7
> -		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
> +			ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
>   #else
> -		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +			ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
>   #endif
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
> +	}
> 
>   	return 0;
>   }
> --
> 2.39.0
> 
> 

+Greg

Hi Greg,

Can you please take this patch series?

Bulk signing of modules is an useful option.
Please let me know your thoughts on this.

--
Shedi

