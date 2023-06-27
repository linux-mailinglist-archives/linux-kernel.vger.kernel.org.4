Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5515C74025F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjF0RkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjF0RkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:40:20 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BC213F;
        Tue, 27 Jun 2023 10:40:19 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-98e2865e2f2so79793066b.0;
        Tue, 27 Jun 2023 10:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887618; x=1690479618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf+1l/vTcyq2/vOLeqcdP9HdilBl9gX1Dtm45t9QQxU=;
        b=iamWs/K/Y2D8/+xFabrLd9y/UbzFjUcwbrdIhmTFweeXQWn/3Qe+VaD0Bj/oX3885G
         k9NTvotpS/DqvMX+pelMahGlWhzmTxUEKEgsd1ETiyB2CC+KqpsxxWAB5DddZgb0/936
         uZ1eUa4+QO+hkHdVObBs5kGLVLERGElrfXz7lAN8ffnxoH9UF8f4HDRgALTHkUsR20yn
         qaluF1ZC1WlYABjY1iFsYUfzTR6mouoS+qKJE2l2KhWOb06tdMabLSGqH2+oOwTLBvyL
         Jcs576CEWjEGairnmhyJ7bYru9+KRB/IiVVUbtHBgm4OEanavph4+A5im0KHiWGiz49X
         3ebg==
X-Gm-Message-State: AC+VfDx7vnjLfcCVWDbj8ZCjPW2hq+B3Ix2ywAepXxow/FthdYn13cbD
        j94D6Ol9/8cDTYh2eBbAQzMNvlmWCWwQA9i+kVq6lPKX
X-Google-Smtp-Source: ACHHUZ4e1ahlo4xk8HkxLywEhnZicsAyZiPa/om6ahQsq1UfNdHRfDvZXT3/rmMcmg+WJWzFPBf/fmsyC2QjuNNTKEY=
X-Received: by 2002:a17:906:73cd:b0:992:387:44d1 with SMTP id
 n13-20020a17090673cd00b00992038744d1mr2198007ejl.7.1687887617769; Tue, 27 Jun
 2023 10:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230627170827.60f9f749@canb.auug.org.au> <f6b0cc15-276c-0058-b201-865556bff31f@infradead.org>
In-Reply-To: <f6b0cc15-276c-0058-b201-865556bff31f@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Jun 2023 19:40:06 +0200
Message-ID: <CAJZ5v0g8ZC6w2H0Ki_2gDJ-vwfHqTOrx+e91jpt+qLMrTTwiaA@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 27 (idle: intel_idle)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: multipart/mixed; boundary="000000000000e0d87b05ff1ff5e0"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e0d87b05ff1ff5e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 6:02=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 6/27/23 00:08, Stephen Rothwell wrote:
> > Hi all,
> >
> > Please do *not* add any v5.6 related stuff to you linux-next included
> > branches until after v5.5-rc1 has been released.
> >
> > Changes since 20230626:
> >
>
> on i386:
>
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_stat=
e_with_baremetal+0x51 (section: .text) -> intel_idle_max_cstate_reached (se=
ction: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_stat=
e_with_baremetal+0x62 (section: .text) -> cpuidle_state_table (section: .in=
it.data)
> WARNING: modpost: vmlinux: section mismatch in reference: matchup_vm_stat=
e_with_baremetal+0x79 (section: .text) -> icpu (section: .init.data)

The attached patch should address this.

--000000000000e0d87b05ff1ff5e0
Content-Type: text/x-patch; charset="US-ASCII"; name="intel_idle-section-fix.patch"
Content-Disposition: attachment; filename="intel_idle-section-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljekobpk0>
X-Attachment-Id: f_ljekobpk0

LS0tCiBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDogbGludXgtcG0vZHJpdmVycy9p
ZGxlL2ludGVsX2lkbGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvaWRs
ZS9pbnRlbF9pZGxlLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMKQEAg
LTIxNDcsNyArMjE0Nyw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbnRlbF9pZGxlX2NwdWlkbGVf
ZGUKICAqIEFsbCBvdXIgc2hvcnQgaWRsZSBzdGF0ZXMgYXJlIGRvbWluYXRlZCBieSB2bWV4aXQv
dm1lbnRlciBsYXRlbmNpZXMsCiAgKiBub3QgdGhlIHVuZGVybHlpbmcgaGFyZHdhcmUgbGF0ZW5j
aWVzIHNvIHdlIGtlZXAgb3VyIHZhbHVlcyBmb3IgdGhlc2UuCiAgKi8KLXN0YXRpYyB2b2lkIG1h
dGNodXBfdm1fc3RhdGVfd2l0aF9iYXJlbWV0YWwodm9pZCkKK3N0YXRpYyB2b2lkIF9faW5pdCBt
YXRjaHVwX3ZtX3N0YXRlX3dpdGhfYmFyZW1ldGFsKHZvaWQpCiB7CiAJaW50IGNzdGF0ZTsKIAo=
--000000000000e0d87b05ff1ff5e0--
