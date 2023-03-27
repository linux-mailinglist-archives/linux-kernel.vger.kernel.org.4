Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF17C6CA693
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjC0N4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjC0N43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:56:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B313C18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:56:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d8so5194717pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679925388;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=UIf5bRzBfUMXz/54gEACPx5wc1XBr3yDReJu7xeSLelHH26DBF11bfeXLhs+Ss8Ryw
         U+XKAZEMI0GL8mpLNJ86oSXDV8tOkziJu5+hsYYVFic1XL3ao5yutKofkEGCUynq0uWb
         vpE/1HTkL7aDYEIFqm5InaaHmzo0leJuaVl/fgF07Ira9YaVqF6qNHc7MmuuooxwssFo
         qkYZ6nAK1ciXHOTd5pugPKy+Yxp+d/CqCnLM9NajduY16Iz0UT7DNOlTTXFuw2FMpkJb
         j27cQuVQiqRUuVxisE8G5ysFMks1ubKKIrWP2X9kL+JKGd3amM1/o266c9HBtY9q0eZY
         nutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925388;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=qC4haOICnsgUnFXbEF4hM7ZkrjCUL6ZF7L3nZ2Pot/DmF/RvGyfwWJyQtuhg5UKOgB
         jeNOBZv72/xfCjcG2uLssn3qcTnhv0Vgpy+PVFgKfJxPZlYg0p4F0MLTqAwMYaB+sHwE
         2BmQ/TtASsIytZy1OEOa/CFrr/6mmsl8McjX6E1BsZeq3LeIyUTn5fNRYvKLudeHe4sW
         AKEkOdqVBTBRZWKx/639dQVcbyjssePeKH3WXQDStuKAnqLE6RDdcwQ/gmSXnhBbx+QJ
         5mqxB9wg9yTh5ZwmnOTGT5VID4LrraIBPBcZ1z+0a6hEcrnZbOqk0m+1RQhlLCW8R1Yj
         kRig==
X-Gm-Message-State: AAQBX9dtvQsvXwshtlhLY9OdqH5mJspcUtzUggkSX7nHRe5QWKmylr8i
        O8eplVMtTv5rYt0RNRgrZYQ28At9HLU0f9E+DHI=
X-Google-Smtp-Source: AKy350ZXKsGSVTB5CUXvpBA9QmN8XJL3rRf6UWF+Zgo3c8FTExOfmtWkqGAVWz1OqE7Q78nzxrO4woetGMipmNzFli4=
X-Received: by 2002:a05:6a00:2e9a:b0:624:1261:918f with SMTP id
 fd26-20020a056a002e9a00b006241261918fmr5764268pfb.1.1679925388014; Mon, 27
 Mar 2023 06:56:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ed27:b0:40a:64ae:d236 with HTTP; Mon, 27 Mar 2023
 06:56:27 -0700 (PDT)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <kevinhansen8819@gmail.com>
Date:   Mon, 27 Mar 2023 06:56:27 -0700
Message-ID: <CA++QgS8EiedgKD5a=Wcw5SBH58e_h_omR4v_Y+Sy_OjU5MCb9A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello friend did you receive my message i send to you? please get back to me
