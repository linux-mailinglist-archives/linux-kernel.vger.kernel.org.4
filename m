Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0165310E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLUMuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiLUMuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:50:19 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10723149
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id t17so36617045eju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=Yqff2tBr9mLzDgQy6wO8YkbyyU+hHsOTHxduzuz6EKnfOR0lu8sqfmQfLshamlMj55
         iVAA8EaJYdBcbzRiPidRkXcu9oG8mq3AKJFuILif+Qw5A9t1mVC0Io31aqbNxssySPHC
         RX9QCUpEarJByBTn6wamfkTD4mjw446EQSC80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv7lgqcsWR7csyQW/ua9GbEMjmdKQM2eL6DIBrKZNHc=;
        b=RlFgxlxZvkrynGFc6uywa4aEJoRPMZe+ZYi8ycBawMDKCjuinavLaRM4U4pdxRKoB8
         skaIuNIa+MNlEJPngcp0j3tkXM1JTdTSFj3yNs5Jnv/TMmV+u+pLRJI/i0cNjw3EoGoq
         390JR7IskzyehsiMUuEHgU+raHEkxoZgOJRV+PgY+sKwrrnFKclTkeujk56fcUnsbnGR
         jfrDENxFKUY/s26qbCnQChPGX8CnvCoCreNf7woYnS6fNGoPUYtQD3zIz+4SXEtw1WL4
         INvI8QIQL2aojzpiowMIKDFy/eVRpl24aFYvBmie6TIlJ9lO7s4jIhNTm4OciBkUxSHe
         cEhQ==
X-Gm-Message-State: AFqh2kqEpfHyktvEkYQxm+8n+OlB/9uO+8msAiI3k5tya65I+g1p/uk4
        jgRm0OOCS6WZyere3eMVhG+Y/w==
X-Google-Smtp-Source: AMrXdXsoMK6w2l5XN1avwOjEmhnplp1Jk46bR5QKm4EGxI7p2LaGCMUWabvtaWyPLZsobJ5r5vfl+Q==
X-Received: by 2002:a17:907:a784:b0:78d:f454:ba4c with SMTP id vx4-20020a170907a78400b0078df454ba4cmr1126807ejc.75.1671627016899;
        Wed, 21 Dec 2022 04:50:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:4b82:b1f8:cb4f:fbbd])
        by smtp.gmail.com with ESMTPSA id w7-20020a170906b18700b007c0b28b85c5sm7039250ejy.138.2022.12.21.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 04:50:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 13:50:01 +0100
Subject: [PATCH v4 1/3] Documentation: sysctl: Correct kexec_load_disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221114-disable-kexec-reset-v4-1-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
In-Reply-To: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6cVA0f3MVv7jTHbprLKEENRfx9C5MeH7N8/eIFjhzo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjowEB2GKKde5eall1LO2Pukz0oHPGS78uqBtODlWc
 0ycx3AKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6MBAQAKCRDRN9E+zzrEiNpsD/
 4/Jd6hh8jIzj6DeUtxGlMzPF8D5zTmDrn/O1OymQxG1FrMk5siVZtOH5aFCarWFYcAhrpdhW4IyzQG
 x0LSbJOT9jtwz5WKENrU42nTbpshboubcK+byC6h9iFYohm+qqWd0DVMtYej85mKcLmBHuT4dp4MoI
 LPkqfifmzf9blmrz2nDD2uArhMxRsApVCT68UqoZcDIALczol/keRjGKk9vZd8N12QMeUEfCZ+uMs3
 dT+AIpxtpZ1NWQpzgdypP9qzvi5ORxV+fA/DkV2ebJ42YUgHdi2NXRE8m7srVCBOLaHJfRSWo0zkGK
 DCjmmjzjvEjbxg2w0zqkQrQXtKge17NMqdFNrorlc3zOootGjCl32IWvL8oLVI4h6GCBzcDSasVvNT
 S2D1C3y/IMgOq+cxa3gwXY9Iq0QKA3eSKGvF211pYJYSXSRfjyx72V2VldqDwD/4XS+8lpJ90Ilwn3
 txPAfh70ipePz0zVIlvic1kAGXOhxdsXlGVQ+azTd6eBL0e40YuhKA6xogOKxMcMsFD5CZNwZdhGQ1
 JkYCGDuyvx5Abq4eX6KsYYAjWrWQ/vOurA90O4gF7DngsY7OB0vWT2T5FJbneNNtj9Nsg/b2HtjoTP
 PpkbxvNdPTJleHpZEy3DIrOPpkM8bU2jp5zQi/q/mxk7hruVcHMZhsZd/x/Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_load_disabled affects both ``kexec_load`` and ``kexec_file_load``
syscalls. Make it explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 98d1b198b2b4..97394bd9d065 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -450,9 +450,10 @@ this allows system administrators to override the
 kexec_load_disabled
 ===================
 
-A toggle indicating if the ``kexec_load`` syscall has been disabled.
-This value defaults to 0 (false: ``kexec_load`` enabled), but can be
-set to 1 (true: ``kexec_load`` disabled).
+A toggle indicating if the syscalls ``kexec_load`` and
+``kexec_file_load`` have been disabled.
+This value defaults to 0 (false: ``kexec_*load`` enabled), but can be
+set to 1 (true: ``kexec_*load`` disabled).
 Once true, kexec can no longer be used, and the toggle cannot be set
 back to false.
 This allows a kexec image to be loaded before disabling the syscall,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
