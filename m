Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6E6821C2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjAaCB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjAaCBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:01:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA553252F;
        Mon, 30 Jan 2023 18:01:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d30so22045039lfv.8;
        Mon, 30 Jan 2023 18:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FX1nguOn530FjieJGxPrgbsgP+PsVHfD0ppimHUX5w=;
        b=b1rqbpSgSAfsYCL4yXbiN+ZYAPXdNQhFr5MPI7LplPGb8GQhW/MAGZkZTZgz61TfmJ
         B3ZNjOxC54EP9WBMrr/xWkqVkUoKBnTK8oy4uzkyvbFO4rLQD5jin7ZmcyQzb2pBiOs3
         5Egajg7mo3Cx/5eAdCuTOvxU8gvx+6K0qISGkmhV93c5Y9eRUHlQrpYwtqCkC9M6L9Sh
         btmZ76dDbXNvw3LldnbDDTQRXrIzC+bOITOv5zIpDBIoQtWijJYyyjIYnndN2auDK9oB
         Sag3/0wXR+0MUD8Ws9qIMZEFsdU4iZefZCEYm8RuhL/0MIeVTgCko4QUSO8aHmQMtln1
         I8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FX1nguOn530FjieJGxPrgbsgP+PsVHfD0ppimHUX5w=;
        b=ou49a074g9m2TguONU8RyySZppB3RrilOWmx3by9lalnjVFTtFdjpfu3CtQNy7MbTy
         Hu6AF6XoFJ1q0AlniydpyFrUvT0t0P/tT/IwIlxlaPCQ/tUzfvM+CN1PsxtSs8hg1wHS
         WK2B9GpQw9+SkJZglBV2wnEFdlyUb+L9bqx8L/otcZHZNI9wlO6z1b3CbbWPjArMpoPy
         iAxlGhSvD0KDgzY067NFWnrCaYZdzOWe4LhmlqDUnXxJnH+lVkS59eiqo9Wx7fE9wwP7
         zfm8HCniqLgLhccWoreLYdehf+emNn7OfQmvXKJDOTVDc2Cr1bPVwDqYysrUKgUhk6jy
         BDdw==
X-Gm-Message-State: AFqh2ko+nfA+p25xohAf1/i0Y4xkJms4ODOPamC9R9atkWhrGRJc4+o8
        NAO+Tiq63SJrDPsD0Z1SN/eh7BRaT9XNa/Ol09w=
X-Google-Smtp-Source: AMrXdXtIEw5TWX9SP7FtHsdK+XkupNgNcR6tiT5Wg0rItxD2DWJf1nMCGQDp9EtG0hmh+ONX0K0aS1FU4f1Yjid8LTw=
X-Received: by 2002:a05:6512:1284:b0:4d5:9957:541 with SMTP id
 u4-20020a056512128400b004d599570541mr5048862lfs.52.1675130478214; Mon, 30 Jan
 2023 18:01:18 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
In-Reply-To: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 30 Jan 2023 20:01:06 -0600
Message-ID: <CAH2r5mstTSBJLRht6QRoJy3yy0pmNxg_CFS0Pid=bikLWzp8_Q@mail.gmail.com>
Subject: Re: [PATCH][KSMBD] fix indentation in ksmbd config and note Kerberos support
To:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000001b584805f385b531"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001b584805f385b531
Content-Type: text/plain; charset="UTF-8"

updated version following David Howell's suggestion for using if/endif
to fix the indentation


On Sun, Jan 29, 2023 at 6:01 PM Steve French <smfrench@gmail.com> wrote:
>
> Fix indentation of server config options, and also since
> support for very old, less secure, NTLM authentication was removed
> (and quite a while ago), remove the mention of that in Kconfig, but
> do note Kerberos (not just NTLMv2) which are supported and much
> more secure.
>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/ksmbd/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
> index e1fe17747ed6..4153e5491435 100644
> --- a/fs/ksmbd/Kconfig
> +++ b/fs/ksmbd/Kconfig
> @@ -33,17 +33,18 @@ config SMB_SERVER
>     in ksmbd-tools, available from
>     https://github.com/cifsd-team/ksmbd-tools.
>     More detail about how to run the ksmbd kernel server is
> -   available via README file
> +   available via the README file
>     (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
>
>     ksmbd kernel server includes support for auto-negotiation,
>     Secure negotiate, Pre-authentication integrity, oplock/lease,
>     compound requests, multi-credit, packet signing, RDMA(smbdirect),
>     smb3 encryption, copy-offload, secure per-user session
> -   establishment via NTLM or NTLMv2.
> +   establishment via Kerberos or NTLMv2.
>
>  config SMB_SERVER_SMBDIRECT
>   bool "Support for SMB Direct protocol"
> + depends on SMB_SERVER
>   depends on SMB_SERVER=m && INFINIBAND && INFINIBAND_ADDR_TRANS ||
> SMB_SERVER=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
>   select SG_POOL
>   default n
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve

--0000000000001b584805f385b531
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ksmbd-update-Kconfig-to-note-Kerberos-support-and-fi.patch"
Content-Disposition: attachment; 
	filename="0001-ksmbd-update-Kconfig-to-note-Kerberos-support-and-fi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ldjlfbgc0>
X-Attachment-Id: f_ldjlfbgc0

RnJvbSBhMzM3MWIzNmQzNDZmOTc1NjAxNmU1MzIxYWNlYmMyZGFhYjk2ODZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFN1biwgMjkgSmFuIDIwMjMgMTc6NDk6NTkgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0ga3NtYmQ6IHVwZGF0ZSBLY29uZmlnIHRvIG5vdGUgS2VyYmVyb3Mgc3VwcG9ydCBhbmQgZml4
CiBpbmRlbnRhdGlvbgoKRml4IGluZGVudGF0aW9uIG9mIHNlcnZlciBjb25maWcgb3B0aW9ucywg
YW5kIGFsc28gc2luY2UKc3VwcG9ydCBmb3IgdmVyeSBvbGQsIGxlc3Mgc2VjdXJlLCBOVExNIGF1
dGhlbnRpY2F0aW9uIHdhcyByZW1vdmVkCihhbmQgcXVpdGUgYSB3aGlsZSBhZ28pLCByZW1vdmUg
dGhlIG1lbnRpb24gb2YgdGhhdCBpbiBLY29uZmlnLCBidXQKZG8gbm90ZSBLZXJiZXJvcyAobm90
IGp1c3QgTlRMTXYyKSB3aGljaCBhcmUgc3VwcG9ydGVkIGFuZCBtdWNoCm1vcmUgc2VjdXJlLgoK
QWNrZWQtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+CkFja2VkLWJ5OiBE
YXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBG
cmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMva3NtYmQvS2NvbmZpZyB8IDgg
KysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMva3NtYmQvS2NvbmZpZyBiL2ZzL2tzbWJkL0tjb25maWcKaW5kZXgg
ZTFmZTE3NzQ3ZWQ2Li43MDU1Y2I1ZDI4ODAgMTAwNjQ0Ci0tLSBhL2ZzL2tzbWJkL0tjb25maWcK
KysrIGIvZnMva3NtYmQvS2NvbmZpZwpAQCAtMzMsMTQgKzMzLDE2IEBAIGNvbmZpZyBTTUJfU0VS
VkVSCiAJICBpbiBrc21iZC10b29scywgYXZhaWxhYmxlIGZyb20KIAkgIGh0dHBzOi8vZ2l0aHVi
LmNvbS9jaWZzZC10ZWFtL2tzbWJkLXRvb2xzLgogCSAgTW9yZSBkZXRhaWwgYWJvdXQgaG93IHRv
IHJ1biB0aGUga3NtYmQga2VybmVsIHNlcnZlciBpcwotCSAgYXZhaWxhYmxlIHZpYSBSRUFETUUg
ZmlsZQorCSAgYXZhaWxhYmxlIHZpYSB0aGUgUkVBRE1FIGZpbGUKIAkgIChodHRwczovL2dpdGh1
Yi5jb20vY2lmc2QtdGVhbS9rc21iZC10b29scy9ibG9iL21hc3Rlci9SRUFETUUpLgogCiAJICBr
c21iZCBrZXJuZWwgc2VydmVyIGluY2x1ZGVzIHN1cHBvcnQgZm9yIGF1dG8tbmVnb3RpYXRpb24s
CiAJICBTZWN1cmUgbmVnb3RpYXRlLCBQcmUtYXV0aGVudGljYXRpb24gaW50ZWdyaXR5LCBvcGxv
Y2svbGVhc2UsCiAJICBjb21wb3VuZCByZXF1ZXN0cywgbXVsdGktY3JlZGl0LCBwYWNrZXQgc2ln
bmluZywgUkRNQShzbWJkaXJlY3QpLAogCSAgc21iMyBlbmNyeXB0aW9uLCBjb3B5LW9mZmxvYWQs
IHNlY3VyZSBwZXItdXNlciBzZXNzaW9uCi0JICBlc3RhYmxpc2htZW50IHZpYSBOVExNIG9yIE5U
TE12Mi4KKwkgIGVzdGFibGlzaG1lbnQgdmlhIEtlcmJlcm9zIG9yIE5UTE12Mi4KKworaWYgU01C
X1NFUlZFUgogCiBjb25maWcgU01CX1NFUlZFUl9TTUJESVJFQ1QKIAlib29sICJTdXBwb3J0IGZv
ciBTTUIgRGlyZWN0IHByb3RvY29sIgpAQCAtNTQsNiArNTYsOCBAQCBjb25maWcgU01CX1NFUlZF
Ul9TTUJESVJFQ1QKIAkgIFNNQiBEaXJlY3QgYWxsb3dzIHRyYW5zZmVycmluZyBTTUIgcGFja2V0
cyBvdmVyIFJETUEuIElmIHVuc3VyZSwKIAkgIHNheSBOLgogCitlbmRpZgorCiBjb25maWcgU01C
X1NFUlZFUl9DSEVDS19DQVBfTkVUX0FETUlOCiAJYm9vbCAiRW5hYmxlIGNoZWNrIG5ldHdvcmsg
YWRtaW5pc3RyYXRpb24gY2FwYWJpbGl0eSIKIAlkZXBlbmRzIG9uIFNNQl9TRVJWRVIKLS0gCjIu
MzQuMQoK
--0000000000001b584805f385b531--
