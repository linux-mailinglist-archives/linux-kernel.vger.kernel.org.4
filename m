Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A706766AA35
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjANIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjANIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:51:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D459F1;
        Sat, 14 Jan 2023 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673686255; bh=zgmY30I4tEWM4rEEvgKQBcv1RAfd1GYCmFE+On31E6M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fNruRlh0nAz40khDRlr1J9FzlT0nIUx9WXF8aWP53rzMxpqOniI2iTQUieZgRtj10
         XOJyml6gJalpmBn+fYxF+AgEJq63sQ15Ldg2YTB6a6958QcylS3WJ7zzbHDcVh7hCQ
         z5AteDfw0OiIGTCGHxHpVejKlCdLw5xyIVregyhkjBILnSSx7eefs8XjOY35/Pruj6
         wL52mSBIGq4GnTTQdKnP2z9pnajs8S9aiafXnJrGrX3NnCrBVcKOkiRwV3inGMmisQ
         SlTdRP2rOtV/p3d1gHGppJMNwDSj2+bHBxJvOluKO7GtQ/6EHVNo8hmm8mkkhdIg+N
         P+R3HDWzsFeLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M1poA-1pIo6h1X6O-002FBB; Sat, 14 Jan 2023 09:50:55 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ACPI: battery: Fix various string handling issues
Date:   Sat, 14 Jan 2023 09:50:49 +0100
Message-Id: <20230114085053.72059-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F9UQ7ho31TcO6Q3T/EScZoWOjgttuOgOrPin1YUcy5bQEL/XuZr
 rWJEq1Z43x04RbUhUn/xpNAeloYyOyhU+lH1R7CXyiSWY+/7y0XfAuEkEO9VFwctP2Vf6Pz
 XogiuuS6ciAdGU3hsYtkmrA0oxJUreNVfrZI223MpUhC1tg3THQLSOl1Tx2e2NjWvvPkpcj
 PYGCufy6tJn6I+aOo5RjQ==
UI-OutboundReport: notjunk:1;M01:P0:amZsE0b69sw=;gDg8sThy349vKQlrCIIxsk5AP6V
 mosjPcZUUtJSueFkdGv/tQTqKtXjSAiUFUJDhNkQ3FWbAo4HVL9kGVyCEcj2H5eO/ScfJ9gVR
 QrMNfuV03gHjuUjJ3yJvg3uAPt5OyPIuEN40lBn2Qz0XzzgWVyd4dplBMT/4bsbz3YffU51Ul
 iAOkL/7XFcSvG63voKR+dB34fDLHwMKSS5vHiPDTFqx6d+gDAoILJMFuQGeG1RqFeui8uFm/U
 Xbd0h46yPiwfxsHSR7AqV/4NvLjQtXunkC+dsjz6PZT8G80I3561BPWSb3IrhcCxyRjFPN1rv
 uBNxzV+wS3onXis0pB20C/XeVufull872c+RAPh0RJ+JuDaMZCdzZBnEpMPRYH48qFM6HuJkH
 c+kyTreV/OHhH5l4sxWdKXHCxq6BDc92FkZciw/7gZRMsxZHQgpHuAGc55wBpqmn3bpc4SmH7
 W3/ro8hdkPGvcy7/wdW17axZdOz1442V92SBxV/q1uxKjilPhwRMd25b68mDxZxuWVIKY2Rt4
 z5ZZxqo0WKpkjIGw/APT3ueMKmpWIY07Jxq7mU/9NtKaafDppblmHtN2qqk8KQgsEMGHGVEAw
 Y/5osflTaYIO7pjnXuSoJGLDi2Lp0UF0OqPrbb1si58MQbUsJj53yeFwZAnX0Se+g4fUURK+7
 LRD0Dp5ViW2SezSQJrl0PcGDMqJSj95MN2LjOx6iiRnT4j6bTXOpSZD8CPz4wZfUjBRLvd7bD
 3M1jfhRz+scJOJ8h7vS4C/4jHvLdzP2ORN05m5UUd5dla+dWP8xi7JSH43g8aAz0t6Mm413dU
 wI7xtrtch6pvKBfNWdNWgeaEnB3f88Xv5l4wWvh2k1lubPydLfVJGxYmRkeh9s8I1mOOuXlrU
 l3JQy3MZxl7qHjcL6lBF7DhDOZmaH7BTiXeyMavb7uHCbp4ZDddO7YMJqYI7QAOnPPDzUV3da
 8cUoMNyQoW/YoGOqYJCEhBejFVc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Dell Inspiron 3505, the battery model name was displayed
differently than when running Windows. While i first suspected an
ACPI issue, it turned out that the real reason was the ACPI battery
driver failing to handle strings larger than 32 bytes.

This caused the model name of the battery (35 bytes long, hex string)
to miss proper NUL-termination, causing a buffer overread later.
Luckely, a valid string was stored right after the now invalid string,
appending only the battery serial number to the original model name.

The first patch deals with this issues, while the second patch fixes
another problem which could happen when handling buffers. The third
patch adds a minor improvement to the string handling code  and the
fourth patch finally increases the maximum string length to avoid
truncating such larger strings.

The patch series was tested on a Dell Inspiron 3505 and appears
to work properly.

Armin Wolf (4):
  ACPI: battery: Fix missing NUL-termination with large strings
  ACPI: battery: Fix buffer overread if not NUL-terminated
  ACPI: battery: Replace strncpy() with strscpy()
  ACPI: battery: Increase maximum string length

 drivers/acpi/battery.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

=2D-
2.30.2

