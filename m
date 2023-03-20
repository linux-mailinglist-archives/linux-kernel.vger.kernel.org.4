Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7606C205B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCTSvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCTSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2D339BBB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s19so1868460pgi.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=llf0mTJk4LCfUt/sw2a+t/X4N4R95uRUH/5f8jnmlmvkcXMFk7PzMSQk4AUP/3qk6N
         lqKcAwwbWsK/dRiXQ966lb3+xeJ8tjjU+QBoO5UwYGwXGXfS4BfgMUy5mgSGRKdXwNHh
         uclE1eEOnaNxiUUOV8yBfVjtp/8vLsRogAglp6fLacSO9Dj7pWsC8yYX/sYqc8rWDMaE
         bC9C90bbjyCRa6WG+S6yAUKB0Vc6aa3E2ENqW1R7/fnxtPKuKs1/MAglXCgzJse7KebH
         j2D8/NdVWB97J+OLCTLNU5oL1VSk3ubiucS4eFrM726+cQ3eAS5W0Ua+ygmOyho7hbZv
         Bjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt1FiyCAq19UTY6Dgky638GY7WS05mpX7yYj+tKdXNE=;
        b=IE30L8SH6JSth/77y9n9SC/kmx07cNS9p/+dX4YTlUsmmVoh7NUUHi2JoYfwCJmk9k
         0oAGNxnhKU0mtI2M4UUYPl65yHGBu+39fQTXXpQ8d2tYZ7HzxN1K3wix+6+d7QlNq95V
         T+O9Ek+61SdsA7TcafKDapNagqDJPAOuKKSYM+yUYr2KhcRfbzNgtS5IZ2mm35/93oqi
         rpDdHkqVeuk60MjMrvJFkSQ+9XjdzhsNT9yxrIhf1SBvLcumsUE/6HDuuIg7Kvbo67gZ
         0p+q+FrPFTLo/XoUcXKBoWhQQ5WAPWji07yss67vbSAEH2STy/6GD19UU6EciAdC42Gl
         WYPQ==
X-Gm-Message-State: AO0yUKURFJ9AthZ55XvJgiy4CTX0mmaXRwkIrOhJf3TCAC/6iSQtSKJ1
        DxmRVhAiBaL7RZWS9aQTzqHffxKGuL1KBA==
X-Google-Smtp-Source: AK7set8pDb8ZhkSv5aTUBz1y+GHVI0CHIr7L0jPY5BNwOR3I5NCp41DVnKUkhh5X0WVd4jFr0EN91Q==
X-Received: by 2002:a62:8417:0:b0:625:a34a:89e8 with SMTP id k23-20020a628417000000b00625a34a89e8mr21057493pfd.2.1679337836273;
        Mon, 20 Mar 2023 11:43:56 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:56 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 5/7] sign-file: improve help message
Date:   Tue, 21 Mar 2023 00:13:43 +0530
Message-Id: <20230320184345.80166-6-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320184345.80166-1-sshedi@vmware.com>
References: <20230320184345.80166-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

Add a proper help message with examples on how to use this tool.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 0a275256ca16..d3abc5721a7e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -74,12 +74,43 @@ struct module_signature {
 static char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
-void format(void)
+void print_usage(void)
 {
-	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
-	fprintf(stderr,
-		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
+	fprintf(stderr, "Usage: scripts/sign-file [OPTIONS]... [MODULE]...\n");
+	fprintf(stderr, "Available options:\n");
+	fprintf(stderr, "-h, --help             Print this help message and exit\n");
+
+	fprintf(stderr, "\nOptional args:\n");
+	fprintf(stderr, "-s, --rawsig <sig>     Raw signature\n");
+	fprintf(stderr, "-p, --savesig          Save signature\n");
+	fprintf(stderr, "-d, --signonly         Sign only\n");
+#ifndef USE_PKCS7
+	fprintf(stderr, "-k, --usekeyid         Use key ID\n");
+#endif
+	fprintf(stderr, "-b, --bulksign         Sign modules in bulk\n");
+	fprintf(stderr, "-r, --replaceorig      Replace original\n");
+	fprintf(stderr, "-t, --dest <dest>      Destination path ");
+	fprintf(stderr, "(Exclusive with bulk option)\n");
+
+	fprintf(stderr, "\nMandatory args:\n");
+	fprintf(stderr, "-i, --privkey <key>    Private key\n");
+	fprintf(stderr, "-a, --hashalgo <alg>   Hash algorithm\n");
+	fprintf(stderr, "-x, --x509 <x509>      X509\n");
+
+	fprintf(stderr, "\nExamples:\n");
+
+	fprintf(stderr, "\n    Regular signing:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module>\n");
+
+	fprintf(stderr, "\n    Signing with destination path:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 <module> -t <path>\n");
+
+	fprintf(stderr, "\n    Signing modules in bulk:\n");
+	fprintf(stderr, "     scripts/sign-file -a sha512 -i certs/signing_key.pem ");
+	fprintf(stderr, "-x certs/signing_key.x509 -b <module1> <module2> ...\n");
+
 	exit(2);
 }
 
@@ -281,7 +312,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 #endif
 
 		case 'h':
-			format();
+			print_usage();
 			break;
 
 		case 'i':
@@ -312,7 +343,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
 			break;
 
 		default:
-			format();
+			print_usage();
 			break;
 		}
 	} while (opt != -1);
@@ -472,6 +503,9 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
+	if ((opts.bulk_sign && opts.dest_name) || (!opts.bulk_sign && argc != 1))
+		print_usage();
+
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
-- 
2.39.2

