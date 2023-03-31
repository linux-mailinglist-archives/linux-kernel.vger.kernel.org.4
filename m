Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E036D1569
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCaCBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:01:36 -0400
X-Greylist: delayed 701 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 19:01:35 PDT
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF26BB88
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:01:35 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=WDr500yg00G+mXxVAkIxehTZby2u/keAH3HrQIYm9bHDXnWYKUtSg2GveqGYNX5BXESH6fNO7vttbhdjKf0A1YIVlOWfaYmT0a/jl5ZDbLPbHgqElGPaHoKPjewI496ESXbIMsG2xslHhvkAiUtWeNOoK1D+cRv4C54h0miU8UN+Cxs0EDXOtLRfRspnwZ2dlDDDUqiYlVCYBNDcEEea4JzXBzSWEw9cn22kHhbfxfe8iO4R8JyFQp9kQzlo6901JX1/dfG40VYaNfAA+vfZFejUsf70mTohesyFYGkBjnr0kEoJVLXIAsYaLd+gkX+2E8I6IKuQC8s8dhcUrZcYSQ==; s=purelymail1; d=jetfuse.net; v=1; bh=f44IWUNbR+7Hx6ud0LmoMxkugb7OBAGfw849+tIiDYM=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=kFbcN8ihbtIBexZFJq0XOk5LD8FxO8k9Xo43skHgSNkk6vFViIDeErskKqcUaFg0g2lhBgyWCpqhXhBXpa+H4R7vjo5jkakwTBzCMgXUCnxhA37hR8ASoRa04VSSPt5YcQH0bj9MqTdoRLa5/SrN2275iOl6K82pQYkLhd6PKj/b8MgcRXVJ5B+wEx2DVr8l7ZzSZ+f0k55/DgjyH0h7H4XGPu+O37Ek7F0ovV+/dxc2xbkqSnbew75ztEbGf4HvY4Au6pexLi8dGbklsQ1t1MhepT3QQIdbOnlGyN1hkNJDz7D1B4DtEaRp5uf+0m2SoAJ59uICKc2L9es+U7mf4A==; s=purelymail1; d=purelymail.com; v=1; bh=f44IWUNbR+7Hx6ud0LmoMxkugb7OBAGfw849+tIiDYM=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 6582:1600:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1293383994;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 31 Mar 2023 01:49:30 +0000 (UTC)
From:   Brandon Nielsen <nielsenb@jetfuse.net>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brandon Nielsen <nielsenb@jetfuse.net>
Subject: [PATCH] Add "X570S AORUS ELITE" to known working boards
Date:   Thu, 30 Mar 2023 20:49:02 -0500
Message-Id: <20230331014902.7864-1-nielsenb@jetfuse.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/gigabyte-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gig=
abyte-wmi.c
index 4dd39ab6ecfa..ca5124e31d2c 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -160,6 +160,7 @@ static const struct dmi_system_id gigabyte_wmi_known_wo=
rking_platforms[] =3D {
 =09DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 GAMING X"),
 =09DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 I AORUS PRO WIFI"),
 =09DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 UD"),
+=09DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570S AORUS ELITE"),
 =09DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z690M AORUS ELITE AX DDR4"),
 =09{ }
 };
--=20
2.39.2

