Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DC6AB274
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCEVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCEVYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:24:43 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B4B762
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 13:24:39 -0800 (PST)
Date:   Sun, 05 Mar 2023 21:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alshehhi.io;
        s=protonmail2; t=1678051477; x=1678310677;
        bh=963jAu3q+hN/mhIrEkuTDfHfmGad9Bx1Amr9B/r2pqE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=EpyuNiAL6Nn9Dbvoo8S15v1cX/km+KXIVe6VZ9/olGfbW/bT5r3NynEae/Eex3204
         M3OUtTid0dN1wGa/LqaA1oGgbX+mc/G0IKXY+elhMsGuCkPqq/YDVBXD4uCXPecWwL
         DhwT4QSISpGA26k32AHw+X/Qo0j4XnqxMzpY3U5++J8b6GY0RnfHDt2Ut2DlcA36oN
         r6Lah5KcNRomytPG90kiNOOysjkHjuM5vCRHXzqPUEHIBLVAL44yhZu4rFGiEcY1iJ
         PRUhFSoV/C07Mkw5P/30u9wruAH3Y2DXkNwboLZotvAvB2w9aSCyhUE8BFjkS0/Mg/
         4X68HRqwAj+sQ==
To:     harry.wentland@amd.com
From:   Husain Alshehhi <husain@alshehhi.io>
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Husain Alshehhi <husain@alshehhi.io>
Subject: [PATCH] drivers/gpu: fix typo in comment
Message-ID: <20230305212411.25727-1-husain@alshehhi.io>
Feedback-ID: 31127354:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "isntance" with "instance".

Signed-off-by: Husain Alshehhi <husain@alshehhi.io>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/=
drm/amd/display/dmub/inc/dmub_cmd.h
index 007d6bdc3e39..734b34902fa7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1971,7 +1971,7 @@ struct dmub_cmd_psr_copy_settings_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2029,7 +2029,7 @@ struct dmub_cmd_psr_set_level_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2056,7 +2056,7 @@ struct dmub_rb_cmd_psr_enable_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2100,7 +2100,7 @@ struct dmub_cmd_psr_set_version_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2131,7 +2131,7 @@ struct dmub_cmd_psr_force_static_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2206,7 +2206,7 @@ struct dmub_cmd_update_dirty_rect_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2344,7 +2344,7 @@ struct dmub_cmd_update_cursor_payload0 {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2391,7 +2391,7 @@ struct dmub_cmd_psr_set_vtotal_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
@@ -2429,7 +2429,7 @@ struct dmub_cmd_psr_set_power_opt_data {
 =09uint8_t cmd_version;
 =09/**
 =09 * Panel Instance.
-=09 * Panel isntance to identify which psr_state to use
+=09 * Panel instance to identify which psr_state to use
 =09 * Currently the support is only for 0 or 1
 =09 */
 =09uint8_t panel_inst;
--
2.39.2


