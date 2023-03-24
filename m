Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA676C78E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCXHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjCXHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:31:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1852D10C8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:31:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z33so216194qko.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643073;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv+/okQpvLPeEesFbW+f0IeMoL7WJaBwrI7ka3EB5Nc=;
        b=eeCN/q6MxHO0ki4tWoq9xAJhL0mehJfTlnEboKNHkBSveOGhiYijONV3Uamwqjabar
         JIgu6OqEdtk2SQHNeKvQh9Fzeq7cgxzCwLbsMmeUHhakKyDyLdwJ6P2LTei4Yfmts4Qx
         8mQDxSud0Z3w+14O8CVRxE/Jl7wdw5J29AqIGpwLV4P1nOEOGuj0QTx5/2ueBT6GYSnq
         f5yitxZjp/yfG3jigApdxdoiNfFCYTBCwbiUymVOMyQ801C51tnQ9Daac3mrJxVomyK7
         jCdv7pjd5t0xFXcJ9p6c7KKOyj78So3pd9CLzd6sLXwI/95VdBefALscvAbpD+Mkx/kT
         BA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643073;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv+/okQpvLPeEesFbW+f0IeMoL7WJaBwrI7ka3EB5Nc=;
        b=wMRXEGXUfhOihUUUwi+ZfNrF/AEQ1FtYUDDkbehw/+bwqLXHP4Am+77K0eBUXc8QG2
         cDq/W59t1RxmI2XdqwSdFZwZsOgnMYPUWWRWrhHr2rbyilz3ftm7tcKr0OkVG2Y0kfzS
         iEW20wtC05UpdONJVLwOMZPn+eUdfhLizH2CCgrnSEilzgX2RyqwQwInfnNv9kC8JbHb
         2yu7mAgriUSRJthnvai11FIBw4WNb1/+/NfVldgX08A5wVC5CtnEW4IP/JqSVc4WiHOY
         QzDGKHjDrUFeWad7nFBVflRaaX1E4n5y5OMVaLcbjN65KyZtvUOsqauDECiY7byVu28k
         ffZA==
X-Gm-Message-State: AO0yUKWu0qWaqEzIXvqIvKO5tHyB5LuLleSVq9swjKG91eZMjJxVhzAq
        oqDDsrUFcB0jfcpBLYw0GwA5TX3Fs5biwqfiTKzDd3N9R/g4Kg==
X-Google-Smtp-Source: AK7set8qiayrCQEmrQ5sKGxmsUtgqmXMfjOom1t/uDcRYLTwBBWLqd9j56uIL47lGmfA8XGGvggkEWjT4TGwIXlo30Y=
X-Received: by 2002:a05:620a:b0a:b0:742:71e6:b8d4 with SMTP id
 t10-20020a05620a0b0a00b0074271e6b8d4mr378929qkg.6.1679643073150; Fri, 24 Mar
 2023 00:31:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:5899:b0:4d4:81fa:9c9 with HTTP; Fri, 24 Mar 2023
 00:31:12 -0700 (PDT)
Reply-To: a54111046@outlook.com
From:   audu bello <gadstra2@gmail.com>
Date:   Fri, 24 Mar 2023 08:31:12 +0100
Message-ID: <CAL1zo1qhwQGN3xOJ967jHMmsBNh2tWOFUkkkFkO7M=8mOs--3Q@mail.gmail.com>
Subject: please confirm urgent
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
I've reached out a couple times, but I haven't heard back. I'd
appreciate a response to my email about pending transaction
