Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051069CF94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBTOmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBTOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:42:32 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D0144A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:42:31 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id e10so1440671vkm.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676904150;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgp6IOUG6iKDfDU0tPmd9yrrDqr92A5QKSnpVkuODbs=;
        b=O0p2bjXV3AoO84lFHvMs1+Q+bn3HXUS08mj0bhgHuqmPY/iuNDj74gw+PtZSEb4nPg
         P9L79f1EkeN2YnA+3hpSO6t8nkcf6QGIGPQgv8/oZk+sCXLf6Hcc81AccqV1ORuiYLOa
         80t8DOaNdmiOw0a76Cy2uZX0xIMU6n2Vz9pk2mk8kDoKAtxna+UyrYPUntib7mFy5BYK
         cpe31edrTnhfplevIuqzbeQ3mrcY21jR/I0aFCwMortTSWIaOOymY9ZqDHRj4lZG02s+
         tKH+SJfq9gw4vSEe2J11fM1dqeDFMR+fh4LJfSTwwhP8GTbh1/Gp+pjWY0sYPUb87LfV
         XeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676904150;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgp6IOUG6iKDfDU0tPmd9yrrDqr92A5QKSnpVkuODbs=;
        b=BmBuCQkOV60vsmyfCDckfxiSXosjJYA1Fo+wvG+WWH8Pv1SrU2d28+PBIxQ0ZPyR7p
         UXcwMB3D8y9kUf3RS5m7qShjVbM5ARTuZJyrQZVwurJml4iniUihipw7LIHsDK351aav
         8XF6GCn25YkWN7USCm0sso6ef3CdFfUsVsDK/ZcBObo4rT5ln11tooWK+Sg/U+llyMrT
         f8n+G+qorPkF+A6pT5ELrYQg9NvaUpyQPr6kwDQ+SvQgeufF+ZDMara1JOqwO4GNe2RA
         T7eaZsbOMUWEUO7ryc2ifm2BUek+X6/ti0sL3yvTBiQLy53XnODExg63ydEOAvc1nMte
         /jBw==
X-Gm-Message-State: AO0yUKXAHd+FJDtRa/ujyzd2kTeW14Qf7N1Ab1/XOrqEx8DiOaXfyoaP
        1ZnhVuYk2eq/7IQF+WATpKZXFv2PMLv6xKGlHxJtkjwo4tqnPKeX
X-Google-Smtp-Source: AK7set//W5nvIuXxc1eW4WJRdB7WNjf+UKQwZq9CtFeqKO1paf9xVbZr7G/Unmm2aBuCdFE19vPJHzuvoaOFufqK7BE=
X-Received: by 2002:a1f:2654:0:b0:401:7237:7c37 with SMTP id
 m81-20020a1f2654000000b0040172377c37mr210030vkm.43.1676904149855; Mon, 20 Feb
 2023 06:42:29 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Feb 2023 20:12:19 +0530
Message-ID: <CA+G9fYt=mHaGEyKeyF+24u=QnDpePNz9_vh3SMK31+mGHSsCTg@mail.gmail.com>
Subject: v4l2-test-controls.cpp(325): expected 8 private controls, got 7
To:     open list <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        nicolas@ndufresne.ca, xavier.claessens@collabora.com,
        benjamin.gaignard@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following v4l2 tests are failing on Linux mainline v6.2 on arm64 hikey device.
Am I missing anything in my test environment ?

Driver Info:
----------
  Driver name      : vivid
  Bus info         : platform:vivid-000
  Driver version   : 6.2.0

Fail  log:
---------
    fail: v4l2-test-controls.cpp(325): expected 8 private controls, got 7
  test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL
    fail: v4l2-test-controls.cpp(366): qctrl.step || qctrl.minimum ||
qctrl.maximum || qctrl.default_value
  test VIDIOC_QUERYCTRL: FAIL
..
    fail: v4l2-test-controls.cpp(473): g_ctrl returned an error (22)
  test VIDIOC_G/S_CTRL: FAIL
..
    fail: v4l2-test-controls.cpp(593): returned control value out of range
    fail: v4l2-test-controls.cpp(706): invalid control 0098f90f
  test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
..
    fail: v4l2-test-formats.cpp(264): fmtdesc.description mismatch:
was 'Y/UV 4:2:0', expected 'Y/CbCr 4:2:0'
  test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: FAIL


Test details,
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14859062/suite/v4l2-compliance/tests/
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14859062/suite/v4l2-compliance/test/VIDIOC_ENUM_FMT-FRAMESIZES-FRAMEINTERVALS/log

--
Linaro LKFT
https://lkft.linaro.org
