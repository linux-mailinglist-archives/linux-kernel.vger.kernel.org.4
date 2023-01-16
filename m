Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3E66BC84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjAPLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAPLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:12:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CE30FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s5so40213329edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+r8P7RYpwj+yaiNayExikbIqAnJK9hISVyi0M3JYIJ0=;
        b=v4rsc1jykazpCo5uojFh+s97Q/YzFGA8N+1UsSnHfu3lkwYsTfRXg+9KirGvsNGX3X
         +9osWRJj8oqpAZRBBQ89zONoUJQNN9B3zMoJBtQOLdZSN1DM9XvXB2g/8gI1JR3hGZfE
         9U6oUiyZwg8UQAtmNYoBl/1H5OvorCWrS/eYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r8P7RYpwj+yaiNayExikbIqAnJK9hISVyi0M3JYIJ0=;
        b=jn67sQ4ZFnIX3QTTMSxwGzlBVOmsMWJObbtoec3ZXowSECU/oXfvuJyQG94YyqBLzx
         IbfwOhm4chTuRbb9ebf2ZiKUmu2pqtYfy0x48RIHnFOnwFd06ZVb/G84QMp4DmE9ypI5
         czaxsbxPv4JGsuVIpUe/u9gxMcx1k372uy79Ws4izq1P2qC25pnvVou4ksKu01JisdTu
         FP1SGUuLXnS2eLZRmoCGiS/IbsxzmxMI1evVy4lZuT7gC1kNJxP6svgh4s8OnXOdW4T5
         1EoZ8QtgVl37EVkIJFODhnNsV029ftOT7dAT8fm4SeYg08LxvRSOgsXuPgqjeV8mSWim
         t8IQ==
X-Gm-Message-State: AFqh2koRGRAL4+vdcg6FYKAXTrz3so+B0POzGcSY5LPFcb5n9U11MlWj
        1w/+pk3gj6RTplmqdqS+PQJfeQ==
X-Google-Smtp-Source: AMrXdXszrqoIYUShgA1e2hezKtYBIY/nZVcGCEIe0dZeY5X7owzoaK9kSMB1Qe9zH5YGTyQIX+Unew==
X-Received: by 2002:a05:6402:12cc:b0:494:cb3b:eb59 with SMTP id k12-20020a05640212cc00b00494cb3beb59mr33798884edx.12.1673867520071;
        Mon, 16 Jan 2023 03:12:00 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0049be07c9ff5sm4116903edb.4.2023.01.16.03.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:11:59 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Subject: [PATCH 0/2] Cover Letter: HID: drop assumptions on non-empty report lists
Date:   Mon, 16 Jan 2023 11:11:24 +0000
Message-Id: <20230114-hid-fix-emmpty-report-list-v1-0-e4d02fad3ba5@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwwxWMC/x3NQQrCMBCF4auUWTuQpBXUq4iLpBnNgEnDTChK6
 d1NXf48+N4GSsKkcBs2EFpZeSk97GmAOfnyIuTYG5xxo7F2wsQRn/xByrm2LwrVRRq+WRuaePXh
 fAlunCJ0IHglDOLLnA4ie20kx1CFOvF/vT/2/Qdab0QjhQAAAA==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kees Cook <keescook@chromium.org>, Hanno Zulla <abos@hanno.de>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673867519; l=3211;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=eizu7LKSN82pcOTH47qDWJQBaohMuyKJKyf/jI8eS48=;
 b=qqzgoP2XYPP4g8leCSh9lbAxHxtf5eG9etcvlcvV/aTZvsKd9/nBxLa63ASKhd+YTx1qo0rD1NYQ
 eVM8SIeUA6bptTPZXicJxkZJsFxxmM9AXmmyTXT5bJ5tfsZUYtNz
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found potential misuses of list_entry() on lists in hid driver
code that are not checked.
Issuing a list_entry() on an empty list causes a type confusion making
the list_entry point to the list_head itself.
The most impactful seems the missing check for an empty list in
hid_validate_values() which is supposed to check the validity of the
reports themselves, potentially affecting all the drivers that rely on it.

The problem is caused by the driver's assumption that the device must
have valid report_list. While this will be true for all normal HID
devices, a suitably malicious device can violate the assumption.

This patch fixes the issue by checking that the lists are nonempty
before allowing them to be used.

At a first glance it may seem that the patches have security implications.
However, when plugging a device which provides a descriptor with no output
report, the type confusions will create a fake struct hid_report*
which points to ((struct hid_device *)hid).report_enum[type].report_list.
This, by chance, makes the type confused structure to span
the `struct hid_report* report_id_hash[256]` array in the
((struct hid_device *)hid).report_enum[type] field.

Then, due to their semantics hid_validate_values() will check
(report->maxfield > field_index) on the type-confused report,
and the maxfield field happens to overlap on the
report_id_hash[] array in the report_enum[type] field
which are all NULL since we provided no reports.
Similarly, for bigben_probe(), the confused report entry is
used in the bigben_worker() function which checks
(report->field[0] != NULL) that, again, overlaps with a NULL
pointer.
It seems there is a commit (918aa1ef104d: "HID: bigbenff: prevent
null pointer dereference") which added the check for report_field
being NULL to bigben_worker() to prevent crashing, but without
checking the actual root cause.

Thus, while being type confusions bugs, they are not exploitable.
I still believe list checks should be added, and the patches on
hid_validate_values() and bigben_probe() merged,
to prevent future exploitability if the shape of the structure changes,
and they do not overlap anymore with NULL pointers.
In this case, it is not exploitable just by the pure chance of struct
member ordering.

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Kees Cook <keescook@chromium.org>
To: Hanno Zulla <abos@hanno.de>
Cc: Cristiano Giuffrida <c.giuffrida@vu.nl>
Cc: "Bos, H.J." <h.j.bos@vu.nl>
Cc: Jakob Koschel <jkl820.git@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

---
Pietro Borrello (2):
      HID: check empty report_list in hid_validate_values()
      HID: check empty report_list in bigben_probe()

 drivers/hid/hid-bigbenff.c | 5 +++++
 drivers/hid/hid-core.c     | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230114-hid-fix-emmpty-report-list-0d9ab58b234d

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
