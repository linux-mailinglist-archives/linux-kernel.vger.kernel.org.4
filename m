Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6408F6EE08D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjDYKpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDYKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:44:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC210C4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:44:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6862e47b1so60515325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682419493; x=1685011493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzaHxOLXT6UXdHCAzhRDOWCLOcaBt/T7Rc5Xxf/XLP0=;
        b=g1y9ZH0BfsWGsvTRf5fUXv06ZUMOCWWiUxMcg8dEP4dgGndI8cUz1hwl2zoNncqsBg
         lE/Gpji8fXQLLO3lQbu525EC55AUQ7+UOWpJJtyt58tiIa2eqUOfbCQP8UsUvoXZUkgb
         OkfN488vsM9MoVNRKB704jplNtADGv1drXNqKqIDwLMydfdEg3GBRnps41UjLInkkhNC
         J5+J++J0ONM3aCxJPWPLqrEZZFXPWhMwuUYfhA0Ra49ueHoOhZqBjUMIhWjsv822HEeZ
         M24VxyvIgvX9KWlemkT7P0BTFW7Y75hso1Q19kNX/jb21wEndrdtQRud86/gLbplX81I
         pi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682419493; x=1685011493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzaHxOLXT6UXdHCAzhRDOWCLOcaBt/T7Rc5Xxf/XLP0=;
        b=X0C65oHLeoIliTiTq0gm5lnGT7/4a2mFU5itVGXBDbUMEYPPMO5qNTG6QDGWFiw3iu
         7hJ+9VVgkAOJ8eWp1UbGjFWa3tMFpxOygv5aCO4JAl98orLxbaaK3KcD8j5cI407MQY9
         ZTbyk+ETe6+DPRJieGPUjTWBK8QTLmGaFRey80mXozOi/kKbOwoIElgzwN/+o2KzGKUV
         0wWK7NOXysMLScDUIcCIILa1dtSIuoc0unR2kuifBbTDfYfDmUD77npk8tcHqsqPfh9r
         X3jbHI/6EHwNOAV64uMviVsdYdzFftPaGABL58+iHoYZn8KZq64LOfMydx432O8xrubq
         w1ZQ==
X-Gm-Message-State: AAQBX9eRLnNher4UEH6G4DvVmvi/Ds+Ut34jCcimNuI+AfA4lom/Z2tw
        DjX/knP2em2MZb5osOpOLd4=
X-Google-Smtp-Source: AKy350a/WiDEAbqLWiTSkS78t3noTMb48XEVewlfRUDjv+0gUOu6QtnqspWB0yEo7H2QhTQmNdP1wQ==
X-Received: by 2002:a17:903:1c4:b0:1a2:9183:a49c with SMTP id e4-20020a17090301c400b001a29183a49cmr21539098plh.32.1682419493509;
        Tue, 25 Apr 2023 03:44:53 -0700 (PDT)
Received: from [10.234.19.237] ([103.19.213.32])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b0019a593e45f1sm8029238plb.261.2023.04.25.03.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:44:53 -0700 (PDT)
Message-ID: <0ae37bcc-4398-644b-a295-1245d73e5450@gmail.com>
Date:   Tue, 25 Apr 2023 16:14:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 0/7] refactor file signing program
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230321193341.87997-1-sshedi@vmware.com>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <20230321193341.87997-1-sshedi@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22-Mar-2023 01:03, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> This patch series refactors the sign-file program.
> 
> Brief of changes in this patch series:
> 
> - Improve argument parsing logic.
> - Add few more easy to remember arguments.
> - Add support to sign bunch of modules at once.
> - Improve the help message with examples.
> - Few trivial checkpatch reported issue fixes.
> 
> Version 6 changes:
> - Fixed commit messages as suggested by Greg and David.
> 
> Version 5 changes:
> - Addressed review comments from David Howells.
> - Fragmented the patches into further small units.
> Link:
> v4: https://lore.kernel.org/all/20230221170804.3267242-1-yesshedi@gmail.com/
> 
> Version 1 - Version 4 changes:
> Did some back and forth changes. Getting familiar with patch submission
> process, nothing significant happened.
> 
> Links:
> v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
> v2: https://lore.kernel.org/all/20230213185019.56902-1-yesshedi@gmail.com/
> v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com/
> 
> Shreenidhi Shedi (7):
>    sign-file: use getopt_long_only for parsing input args
>    sign-file: inntroduce few new flags to make argument processing easy.
>    sign-file: move file signing logic to its own function
>    sign-file: add support to sign modules in bulk
>    sign-file: improve help message
>    sign-file: use const with a global string constant
>    sign-file: fix do while styling issue
> 
>   scripts/sign-file.c | 292 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 209 insertions(+), 83 deletions(-)
> 
> --
> 2.39.2
> 
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <linux-kernel-owner@vger.kernel.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
> 	by smtp.lore.kernel.org (Postfix) with ESMTP id 04233C6FD1D
> 	for <linux-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 19:34:57 +0000 (UTC)
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>          id S230310AbjCUTez (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
>          Tue, 21 Mar 2023 15:34:55 -0400
> Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
>          lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
>          with ESMTP id S230287AbjCUTeq (ORCPT
>          <rfc822;linux-kernel@vger.kernel.org>);
>          Tue, 21 Mar 2023 15:34:46 -0400
> Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
>          by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127EC570B5
>          for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:09 -0700 (PDT)
> Received: by mail-pf1-x42d.google.com with SMTP id fd25so9747574pfb.1
>          for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:09 -0700 (PDT)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>          d=gmail.com; s=20210112; t=1679427226;
>          h=content-transfer-encoding:mime-version:references:in-reply-to
>           :message-id:date:subject:cc:to:from:from:to:cc:subject:date
>           :message-id:reply-to;
>          bh=JfE1Pm3xCC/xMjfmbV6dg9bDdIIYNa99PYfAs69HM0w=;
>          b=lg/FcqI+lffJF0M/bbmFlheKKJUVTXCS5F8jAhnrBAvXyA2IqG/9hmNjzvsDp5ngKk
>           SDO3W2J+fE6lLOj/TSKcsSfKiFb6PBXyAUEVycnCvhNuN9U4QO10ihmPCnwMX6t+okTd
>           V7073khKaNF0l7HH0sODuuxEBuR26SC2Sfr3Ejf/A3DwrerYutz/aKdNC06BGtcx9VTd
>           jOqI5hf/s5xGB8YKp8zGdbn0XnRG5QE7Io2dLaEw2EDU6RVp+0sQBepgBPbMNnM1vGVC
>           w2gtIizlYIO1WyZAXij+vlqgRARBPm42MVPHtG3mEBeVhkuHvcJl9KuzowBZXUqqcm+P
>           ELjQ==
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>          d=1e100.net; s=20210112; t=1679427226;
>          h=content-transfer-encoding:mime-version:references:in-reply-to
>           :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
>           :subject:date:message-id:reply-to;
>          bh=JfE1Pm3xCC/xMjfmbV6dg9bDdIIYNa99PYfAs69HM0w=;
>          b=EycJZurnMRKaNtbX9dO0lkGbc2874R1xwH37vsERv4GSiRcqjNFXyQNcKfdgoQCLir
>           C9Y2TX/5Z1RO8h9Q4jLrVKwd4ET+uxWuartUjIxLWn54dRlyT0iQErQ9D1D9u7WlFcL+
>           Rzb54LhQ8OsPRnq5EL6pWlV9kwz1f+vRdhGSLzr9Yh9SgcdmfC795gVip2Q4AqoJtPy5
>           qyUK9YLjRALEsrfQ6Dv5qa1YHZgJI0pvT5JGj+mG4ivQA8GohclChNDilLqL4bWjrmMJ
>           Tsh3y/gU2tvHVzFFclSnR5aLMeyq/YJ0TeQIY2kfY55La4dcKa/vN4zoInzMJtGSauaD
>           0AyQ==
> X-Gm-Message-State: AO0yUKXAn7Kq+WcFipmZkubkO6+9cgkbmRpOdXeWo0Ec3Ybm6KP4x9H4
>          jmstKnTCBbBo/srwNR0LEHc=
> X-Google-Smtp-Source: AK7set+AIpPB2wg+jmk+XWvuY7jaNO6CT8aybg2knfYtPhrLXe9DgrH3ebZsJ6n8B4fdOysRGySkBA==
> X-Received: by 2002:a05:6a00:2e1e:b0:626:2bb0:30d4 with SMTP id fc30-20020a056a002e1e00b006262bb030d4mr1076267pfb.8.1679427226423;
>          Tue, 21 Mar 2023 12:33:46 -0700 (PDT)
> Received: from f37.eng.vmware.com ([66.170.99.1])
>          by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.45
>          (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>          Tue, 21 Mar 2023 12:33:46 -0700 (PDT)
> From:   Shreenidhi Shedi <yesshedi@gmail.com>
> X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
> To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
>          dwmw2@infradead.org
> Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
> Subject: [PATCH v6 1/7] sign-file: use getopt_long_only for parsing input args
> Date:   Wed, 22 Mar 2023 01:03:35 +0530
> Message-Id: <20230321193341.87997-2-sshedi@vmware.com>
> X-Mailer: git-send-email 2.39.2
> In-Reply-To: <20230321193341.87997-1-sshedi@vmware.com>
> References: <20230321193341.87997-1-sshedi@vmware.com>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> Precedence: bulk
> List-ID: <linux-kernel.vger.kernel.org>
> X-Mailing-List: linux-kernel@vger.kernel.org
> 
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> - getopt_long_only gives an option to use long names for options, so
>    using it here to make the app usage easier.
> 
> - Use more easy to remember command line argument names
> 
> - Introduce cmd_opts structure to ease the handling of command line args
> 
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> ---
>   scripts/sign-file.c | 97 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 78 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..94228865b6cc 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -213,15 +213,77 @@ static X509 *read_x509(const char *x509_name)
>   	return x509;
>   }
>   
> +struct cmd_opts {
> +	char *raw_sig_name;
> +	bool save_sig;
> +	bool replace_orig;
> +	bool raw_sig;
> +	bool sign_only;
> +#ifndef USE_PKCS7
> +	unsigned int use_keyid;
> +#endif
> +};
> +
> +static void parse_args(int argc, char **argv, struct cmd_opts *opts)
> +{
> +	struct option cmd_options[] = {
> +		{"rawsig",	required_argument,  0,	's'},
> +		{"savesig",	no_argument,	    0,	'p'},
> +		{"signonly",	no_argument,	    0,	'd'},
> +#ifndef USE_PKCS7
> +		{"usekeyid",	no_argument,	    0,	'k'},
> +#endif
> +		{0, 0, 0, 0}
> +	};
> +
> +	int opt;
> +	int opt_index = 0;
> +
> +	do {
> +#ifndef USE_PKCS7
> +		opt = getopt_long_only(argc, argv, "pds:",
> +				cmd_options, &opt_index);
> +#else
> +		opt = getopt_long_only(argc, argv, "pdks:",
> +				cmd_options, &opt_index);
> +#endif
> +		switch (opt) {
> +		case 's':
> +			opts->raw_sig = true;
> +			opts->raw_sig_name = optarg;
> +			break;
> +
> +		case 'p':
> +			opts->save_sig = true;
> +			break;
> +
> +		case 'd':
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
>   	char *hash_algo = NULL;
> -	char *private_key_name = NULL, *raw_sig_name = NULL;
> +	char *private_key_name = NULL;
>   	char *x509_name, *module_name, *dest_name;
> -	bool save_sig = false, replace_orig;
> -	bool sign_only = false;
> -	bool raw_sig = false;
>   	unsigned char buf[4096];
>   	unsigned long module_size, sig_size;
>   	unsigned int use_signed_attrs;
> @@ -229,13 +291,14 @@ int main(int argc, char **argv)
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
> +	int n;
> +	struct cmd_opts opts = {};
> +
>   	OpenSSL_add_all_algorithms();
>   	ERR_load_crypto_strings();
>   	ERR_clear_error();
> @@ -247,23 +310,19 @@ int main(int argc, char **argv)
>   #else
>   	use_signed_attrs = PKCS7_NOATTR;
>   #endif
> +	parse_args(argc, argv, &opts);
> +	argc -= optind;
> +	argv += optind;
>   
> -	do {
> -		opt = getopt(argc, argv, "sdpk");
> -		switch (opt) {
> -		case 's': raw_sig = true; break;
> -		case 'p': save_sig = true; break;
> -		case 'd': sign_only = true; save_sig = true; break;
> +	const char *raw_sig_name = opts.raw_sig_name;
> +	const bool save_sig = opts.save_sig;
> +	const bool raw_sig = opts.raw_sig;
> +	const bool sign_only = opts.sign_only;
> +	bool replace_orig = opts.replace_orig;
>   #ifndef USE_PKCS7
> -		case 'k': use_keyid = CMS_USE_KEYID; break;
> +	const unsigned int use_keyid = opts.use_keyid;
>   #endif
> -		case -1: break;
> -		default: format();
> -		}
> -	} while (opt != -1);
>   
> -	argc -= optind;
> -	argv += optind;
>   	if (argc < 4 || argc > 5)
>   		format();
>   

Hi Greg and David,

Can you please review the latest patch series? I think I have addressed 
your concerns. Thanks.

-- 
Shedi

