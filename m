Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6B60ED6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiJ0B1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiJ0B06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:26:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FA6B64B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:26:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so20472pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHA4PABhtEK1rXCzmMniG/pV1qITSZAaITYQ81bgOXc=;
        b=oZtRdUiV4y1KcexeIjhm5ZaiRVBbr/CjhTTKej0NGu1CTmnwmXu37d0Y24JHY7HEKt
         7s6XazoTKjYXoD0jedPfTjRl2jwpQHqzet7yg/RjpRRJyOjObRZXttCs4veLT3lIHD86
         C29pmXUHUx7AHZgZH5G/JGnL39YQdSckDLNy5IN/45+EFgSeF/gHH88qdut8K6fQiXC3
         VOaMOo5QbFS3Fnd0ntmFp1ZuMUUURgyHRHi4eJ3H+KC+toON1Pity1aBmGFLZBYVfxfX
         ymSxLypehov09orGq+EaXgAj54GIVn9L35j3wf2mY01wTIHVmKy+upRoqyPhG2h7uSUF
         FUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHA4PABhtEK1rXCzmMniG/pV1qITSZAaITYQ81bgOXc=;
        b=Mo/0192qbMNiIXIvZ98HLE2ds9Mvm4g/9yxS93Ex7r51ZLiieE/o49j0reRdJ9cBIx
         O8kUiXVIjUXGYgnsBWChlqvYykUHWbf+qXczYMRx2VItalwjeqHoLS3wkSsXGr18ac7X
         8aYtiCAR+Zzk/7dQYiD1kNs27tu0o5Vp60F2Den2WNJjRlZvtQvfwRilHUBkuVl4Wcdb
         Od2N+xoP2L6ohxj/C912d77nJZx0HQhZYhAgozcIk1e0h1WL1aHwv7eU4QoQxpN4z+xT
         j4L7YdF69baep2mhlu7NPq7vY72EjBotsfp9kijWWTAOOi58CH72MrpeL+fH7Am5W16g
         2fyA==
X-Gm-Message-State: ACrzQf2ogqmkbu4GIrqU9qtPrzYsF6c7isBGxmQKJDgQ0vn2Hwx2sTQf
        0kAMrpg5oXqlbtTiMQCk2pxbIg5So90XyA==
X-Google-Smtp-Source: AMsMyM5iDQZ1vf+K1ir7PueOek+T8gwlbragRmvnz13FTxQqYHuoSKpX0U4SaMmHLduBrvhlMpefGQ==
X-Received: by 2002:a17:90a:b10b:b0:212:fbc3:e623 with SMTP id z11-20020a17090ab10b00b00212fbc3e623mr7386982pjq.5.1666834017847;
        Wed, 26 Oct 2022 18:26:57 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a178600b00210c84b8ae5sm7533pja.35.2022.10.26.18.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 18:26:57 -0700 (PDT)
Date:   Wed, 26 Oct 2022 18:26:54 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
Message-ID: <Y1neXqVYZ8mq8jH+@marshmallow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ternary statements that pick the min of two values can be replaced by
the built-in min() function. This improves readability, since its quicker
to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 6aeb169c6ebf..0cf7d9f82b83 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1551,7 +1551,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 		wps_ie = rtw_get_wps_ie(buf, ielen, NULL, &wps_ielen);
 		if (wps_ie && wps_ielen > 0) {
-			padapter->securitypriv.wps_ie_len = wps_ielen < MAX_WPS_IE_LEN ? wps_ielen : MAX_WPS_IE_LEN;
+			padapter->securitypriv.wps_ie_len = min(wps_ielen, MAX_WPS_IE_LEN);
 			memcpy(padapter->securitypriv.wps_ie, wps_ie, padapter->securitypriv.wps_ie_len);
 			set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
 		} else {
-- 
2.34.1

