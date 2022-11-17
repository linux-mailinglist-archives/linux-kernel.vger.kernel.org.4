Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5004C62D475
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiKQH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiKQH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:56:19 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071817E32
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:56:17 -0800 (PST)
Date:   Thu, 17 Nov 2022 07:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1668671775; x=1668930975;
        bh=WYuRefUyKGr6lMweRSCbo3l2TIHxHgZBvU3a5FItoNs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MbZLgtY/j47Dw22xljN6e7r0bo46ItdP5YGdDrUUoDwx6Vnv8jDKfuXZnGrstuC3x
         MrHMiAlWFV7z1yHgl5Yjf+JQ+4oIv4TF3dGbHvnDY7uYS11pj/zEwCyfodhhPl8obV
         fClzkIiWGaUBDf4yB7/vFfMAsc7579C+XbsN3PecMDD9b04G7juRtBxeZGDHYYsHdR
         pj1GHcMKxAze5bslODwcSfFQCAJDdPSNFgzIePH8rGNj5gQ5RzKI50KsuPHSBnmvuE
         zX0rDm03ODf+NYZKwUAy7Wm3f9I/VZLVfeXcwptLOZ8AcDdrgZJb+TAWW08bHtO1wU
         zwCHQS9vdlR8Q==
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
From:   Simon Ser <contact@emersion.fr>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, roman.li@amd.com,
        aurabindo.pillai@amd.com, Jerry.Zuo@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: rewrite the check for mods
Message-ID: <rCi2ckxzcwtJsZr86hXMQnk3b1ARq6wXXoNiQe-6cQzinJ7CSzUABqf7k5GfIhKoLQ3wXGOQJPR0TjW2Ddn5sM5ht61w_NEHHeSPdGaIwc0=@emersion.fr>
In-Reply-To: <20221117073258.21214-1-jiasheng@iscas.ac.cn>
References: <20221117073258.21214-1-jiasheng@iscas.ac.cn>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks the "size" out-parameter.
