Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4165446E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiLVPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:41:28 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E121A82A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671723651; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Jqc0VQquB+j/zoLYAQH9Bx3xekdzsxmrYlcQwoDHDi7zlpxZIHxuIoo61kvRXM+GD8pz9VuANzJ4pO+RH26K0QwFIspawTa2DV9sYfdbG0n7e4OzXkAY7W/+vPp5ECOR8pWfCtIcZRKe8ynQUC6Cw8SfPGnvWMySGrJu3gbSUOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671723651; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jOS7lFqPyYp4aF6uyo+Mu87tNYK2Fubh9HQ2gBzQ9pY=; 
        b=dYu0F1rb0hwU/HMv7vvPxKe3VACmJwvUaoRfSBueVni/13B9C3nlb5KuSgK4gGq2IzlAzEj7KKQDejBFEqcvQ9orVkHfwZ40jwc/lUBG6aldblKUKIHY/rRvei+NtifpGNMQTXr7VUvrNPVblViYegcJCrZTxp6aX1gyuGLFlLc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671723651;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=jOS7lFqPyYp4aF6uyo+Mu87tNYK2Fubh9HQ2gBzQ9pY=;
        b=ZwaW4OiBc8H0sdC6pEw/EDve8LxAnsN78Dhmm2TraAW9sb5BnMEVMEBROldnTfDd
        nf/Gahc3ZqjACQXVgPafDwqoNwUruYKpziEyl26ScP8QCeIVEyM85siXvwPhRMHIEox
        VLAZJHS04wzyBuCdON7Hq/F4EF+aUaNmI3VvdikY=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 167172365051070.15665484717306; Thu, 22 Dec 2022 21:10:50 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <58ca4a915c1ff714198316365afbb7fb2da1bf8b.1671723195.git.code@siddh.me>
Subject: [PATCH v2 8/9] drm/drm_blend: Remove usage of deprecated DRM_DEBUG_ATOMIC
Date:   Thu, 22 Dec 2022 21:10:42 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1671723195.git.code@siddh.me>
References: <cover.1671723195.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_print.h says DRM_DEBUG_ATOMIC is deprecated in favor of
drm_dbg_atomic().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Simon Ser <contact@emersion.fr>
---
 drivers/gpu/drm/drm_blend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index b4c8cab7158c..6e74de833466 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -450,8 +450,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09int i, n =3D 0;
 =09int ret =3D 0;
=20
-=09DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
-=09=09=09 crtc->base.id, crtc->name);
+=09drm_dbg_atomic(dev, "[CRTC:%d:%s] calculating normalized zpos values\n"=
,
+=09=09       crtc->base.id, crtc->name);
=20
 =09states =3D kmalloc_array(total_planes, sizeof(*states), GFP_KERNEL);
 =09if (!states)
@@ -469,9 +469,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09=09=09goto done;
 =09=09}
 =09=09states[n++] =3D plane_state;
-=09=09DRM_DEBUG_ATOMIC("[PLANE:%d:%s] processing zpos value %d\n",
-=09=09=09=09 plane->base.id, plane->name,
-=09=09=09=09 plane_state->zpos);
+=09=09drm_dbg_atomic(dev, "[PLANE:%d:%s] processing zpos value %d\n",
+=09=09=09       plane->base.id, plane->name, plane_state->zpos);
 =09}
=20
 =09sort(states, n, sizeof(*states), drm_atomic_state_zpos_cmp, NULL);
@@ -480,8 +479,8 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct=
 drm_crtc *crtc,
 =09=09plane =3D states[i]->plane;
=20
 =09=09states[i]->normalized_zpos =3D i;
-=09=09DRM_DEBUG_ATOMIC("[PLANE:%d:%s] normalized zpos value %d\n",
-=09=09=09=09 plane->base.id, plane->name, i);
+=09=09drm_dbg_atomic(dev, "[PLANE:%d:%s] normalized zpos value %d\n",
+=09=09=09       plane->base.id, plane->name, i);
 =09}
 =09crtc_state->zpos_changed =3D true;
=20
--=20
2.35.1


