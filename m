Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1166E713C48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjE1TNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjE1TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:13:52 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECEED
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 12:13:46 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id 71dfb90a1353d-456d0287ec1so712551e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685301225; x=1687893225;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=sXPi2X426mPl4eb+1u5W7Y+HQdns/X6wiaf4foCP13dkcB0ZmXbQi6JGHQjAoQz3ml
         od6nm744TCR0jkXNGBXg48kVf9wB/86jqF1y/utwGBWhQyh3JrTN5oFj8tAF+6NkAto5
         UP3GRC2bnpQ42ravdTvsKj8GwpI54+A0fqnaS+BizWN/DD97gsuepml11v+EU8VfzF6/
         o3JvFV3XwILWlAieT5Rsv/oS0HR9tqVTPSR31NCRIWVbj4DgzQU7dGPxdSZsvxprGcls
         3kRr5VRpc/1lkhuIf4NBoAROtROpydXCKBnN3E0CGJU+9bBuQpdXUqGALszkniODOBoT
         bmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685301225; x=1687893225;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=KdqQe66YOk7rZ6922fz5h1GgdBZXXoThnW0ezYzxVIE3v9zWb8DpLA5hkKocfDTvEz
         1Q02rU/8WxU/m7c7SMHO6N3OmqEHsrxDyUox0vfspowPD4Z1pmI3iTmESXTp1QCF9Sxg
         ICR/G/oWaRRgdvFtr+J6uhVkD1/NJr+UyZD1FMBiB5fwF7ATxAeaN97uwbHXBC0lcY6I
         /PtG2Pni+zf9kwzkvYeOHvuDI/qX166Qyao18sglLtfrJeKm6K92K9hwXpl139dXzCmL
         f4DeaI7P63MvHpoOHzSy9Ej+pRorKujUceWUyXn7uv2gzJWzDf7En1pn1bbdiIljmd7b
         5Geg==
X-Gm-Message-State: AC+VfDxQOZtQRx5ARUEyCmJ2ZrIkzIwxJVKPWLdIxzbz9RMIvYLzfbnL
        7F0ptZPJAUK7usIo6sHkmRAor8c5GeeLZfAhMD0=
X-Google-Smtp-Source: ACHHUZ4fg90/Wuk3k7hUg+7zLpoDJToKcPMbbyH5zt5rv/cxH21boqAl9ii0wxCLF57LorK+kpOSrspG8VYw9uL32U0=
X-Received: by 2002:a1f:5343:0:b0:44f:acc2:1279 with SMTP id
 h64-20020a1f5343000000b0044facc21279mr1684513vkb.8.1685301224508; Sun, 28 May
 2023 12:13:44 -0700 (PDT)
MIME-Version: 1.0
Sender: belhassenneila501@gmail.com
Received: by 2002:a59:b9ae:0:b0:3ca:b17b:fc8f with HTTP; Sun, 28 May 2023
 12:13:43 -0700 (PDT)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Sun, 28 May 2023 19:13:43 +0000
X-Google-Sender-Auth: dL6vefZFP7fjsdfRpvarRDL3T9w
Message-ID: <CAKCh0Vy6Q-v2r7oJf+_2iJbVye3=UB+oBJccA0qB6s=u=peM2g@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
