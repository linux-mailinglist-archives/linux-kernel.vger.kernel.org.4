Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1165F4EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJEDfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJEDej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:34:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27376440;
        Tue,  4 Oct 2022 20:30:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so2850606ejr.2;
        Tue, 04 Oct 2022 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhtD3Nxeo233ijtaBGAkFch/kfp5ptj7ps5Ve0jS3rE=;
        b=PwXAORUakcWhQUOq+9BdIiqm5+8hgckUXnhGYtenuGEQKFD2WR5BXzI0aZjcNWIcW2
         MLfOfhA+zo30sbiASXK/KLXM7FVB5qiT46CvHWSYUYXZIUCwbK8JUuWjm8j1dqxJnfaO
         /nvIQ4pO5tXkPmtMW1vMP8jbeiHjGBgtPJVfICYQYeZUbBdxblgGPg0ofZDan4t6vOhp
         luGdjgmmxpJ+ExWCcy6VEx4YfvNhXk5ezdF/APujX0Xj4TsXwz5o3WUacfKba0nHvGId
         tGi/n/EKJUpVUzgz8LTcQyCO2q2fBEEAnWBYPYHfNthW7BfVU+1wKMcg3ZYDDrqXzu35
         YUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhtD3Nxeo233ijtaBGAkFch/kfp5ptj7ps5Ve0jS3rE=;
        b=yNjIJBDm8R0aEQahc4jXeztosRgJdsaK9Q3SoqIhMlzUkUeDtYQdoSSpqaxhwIVgSp
         n5OHb046teQonXEmNDYsJuBofSHjpLLepdYEBI7+9KtTURjCLEKL3QhMfzwH/Ho2OTmt
         CKUGaHQU6Q5MIIbBxoe2rcn9Ut9azi4zMJMJWg0iTigxZ98lD7ow1CdBpCKO/RryZ+x7
         iJgDzTZPUBrP3lbuy2Y5J2Hlo9lqhV3DGqUqu0XcfDnKuEjzFMo3J8wnCiWONQn2Q1Dn
         Wp0ivW3fKbUMFp2wV4KI/oVK9rJCEnVeM9Mp4TD7KSr+2+RovnEbaPW0YIfw9JYFyMdI
         eirw==
X-Gm-Message-State: ACrzQf3Kyez85U7cFoPUciuJHCGiCPaiN63TJ/X3xegV5EINg5Z/4qlb
        4oRc+alCuaXu9sUgpm/e5tYoKy0v5jTS6CCLFCw=
X-Google-Smtp-Source: AMsMyM5A5Rg0fahdHRX2NmyF9xDhTtT+izdF3OpQ519ZZD4mACJaPW88EtlUSodvSQxp8WVYYjo2cDNK1yEUWgDtkB8=
X-Received: by 2002:a17:907:7b95:b0:731:113a:d7a2 with SMTP id
 ne21-20020a1709077b9500b00731113ad7a2mr21333233ejc.377.1664940624371; Tue, 04
 Oct 2022 20:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <YzzjKyHDuFoQAVCu@work>
In-Reply-To: <YzzjKyHDuFoQAVCu@work>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Wed, 5 Oct 2022 13:30:11 +1000
Message-ID: <CAN05THRcwWjJiYyBdVuVZrvqgK4VP7LKiNQ=XVMg5oOy5u9kzg@mail.gmail.com>
Subject: Re: [PATCH][next] cifs: Replace a couple of one-element arrays with
 flexible-array members
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 at 12:31, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> member in structs negotiate_req and extended_response, and refactor the
> rest of the code, accordingly.
>
> Also, make use of the DECLARE_FLEX_ARRAY() helper to declare flexible
> array member EncryptionKey in union u. This new helper allows for
> flexible-array members in unions.
>
> Change pointer notation to proper array notation in a call to memcpy()
> where flexible-array member DialectsArray is being used as destination
> argument.
>
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.

Looks good to me.
Reviewed-by me

Thanks for verifying that it does not change the binary utput.

>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/229
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/cifs/cifspdu.h | 7 ++++---
>  fs/cifs/cifssmb.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> index aeba371c4c70..d1abaeea974a 100644
> --- a/fs/cifs/cifspdu.h
> +++ b/fs/cifs/cifspdu.h
> @@ -483,7 +483,7 @@ put_bcc(__u16 count, struct smb_hdr *hdr)
>  typedef struct negotiate_req {
>         struct smb_hdr hdr;     /* wct = 0 */
>         __le16 ByteCount;
> -       unsigned char DialectsArray[1];
> +       unsigned char DialectsArray[];
>  } __attribute__((packed)) NEGOTIATE_REQ;
>
>  #define MIN_TZ_ADJ (15 * 60) /* minimum grid for timezones in seconds */
> @@ -508,13 +508,14 @@ typedef struct negotiate_rsp {
>         __u8 EncryptionKeyLength;
>         __u16 ByteCount;
>         union {
> -               unsigned char EncryptionKey[1]; /* cap extended security off */
> +               /* cap extended security off */
> +               DECLARE_FLEX_ARRAY(unsigned char, EncryptionKey);
>                 /* followed by Domain name - if extended security is off */
>                 /* followed by 16 bytes of server GUID */
>                 /* then security blob if cap_extended_security negotiated */
>                 struct {
>                         unsigned char GUID[SMB1_CLIENT_GUID_SIZE];
> -                       unsigned char SecurityBlob[1];
> +                       unsigned char SecurityBlob[];
>                 } __attribute__((packed)) extended_response;
>         } __attribute__((packed)) u;
>  } __attribute__((packed)) NEGOTIATE_RSP;
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 7aa91e272027..7a808e41b1b8 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -465,7 +465,7 @@ CIFSSMBNegotiate(const unsigned int xid,
>         for (i = 0; i < CIFS_NUM_PROT; i++) {
>                 size_t len = strlen(protocols[i].name) + 1;
>
> -               memcpy(pSMB->DialectsArray+count, protocols[i].name, len);
> +               memcpy(&pSMB->DialectsArray[count], protocols[i].name, len);
>                 count += len;
>         }
>         inc_rfc1001_len(pSMB, count);
> --
> 2.34.1
>
