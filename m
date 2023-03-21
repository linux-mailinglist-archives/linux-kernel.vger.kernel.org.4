Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2496C314D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCUMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCUMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:13:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2260E1C30A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:13:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x17so18832577lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679400791;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYqkAHx4YZlodAh/pQZnASbt6AOErr4tdDt3mzzR2k4=;
        b=fqB9/rqHq8O4sMVSj3wEH7oY//2TiKs/CK0O68QgUv3tUUgjbs+FCViYdMmBuUaSmH
         VGB0uTw8TmslnHkNlNxRgZNwkJEime1Nv+moMqis2ogFAg1SnX5QgN46ItSmd8dqHzfV
         GzdaUd9rBsPR/fKEg8VvGMg0W8MFO9V34ZgGX7OHqmIaUc+mZBNic2IZLNNnfNRTDdt1
         uBnlx9ZKCW6wWG3ZUK4ON3kbKy6ZOFvn8b1fsSeRNrVmOCkrFRQ44Rk9rsFQlkQGZhso
         59U793jZ6H0z98AraaQa+E2h3LKNvqnCjih6KWH+St0Ih630RBFOQC+u2JuZmFztC3y6
         qJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679400791;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYqkAHx4YZlodAh/pQZnASbt6AOErr4tdDt3mzzR2k4=;
        b=yFwn7prMz/YZwG92sI5GlWVgJ0Rj2P1ZzllxdaFzNJMkcBmGyB2oEBov+Ew+Yyytf3
         mE4AKrpy6vRPbcCl/hev76U/Iy0bxkdt30FzeA6gcifBitiyEnBWQM8NpnvY0KQYOMHv
         V9BHhTqGtynLbzgRn7b/cNrelU3bDGu1gr2Dv7BLujtjWQEdcu6Ls/h3hZe5rcAGWifx
         jGOcKP8NIMfyS0qzJiSBj6n4wrtoKL2dzKtI1+QaCGR0NxQYKm7ctNmDPpaY4M81WmV+
         0KIKhMVbUPwX5pHvJSCIccq+2gX+fhH4mjA3fnIiNTv/oM/0cD+UUls3rvIBphtBluZW
         5Wcg==
X-Gm-Message-State: AO0yUKU5Kf+soqGW1uLM1myqdUGBrBj22LLFkymGF3v5m3Tlcl+8861J
        x0sdyo5ojKz2pmwNVm2qhoApPiXM46+s8MrfSiI=
X-Google-Smtp-Source: AK7set+ksR2Z7IHoL8ySutIW4fsbmZ9q8MTYXeAmlBh7d8OP70Cy4dhWvs1dQeNBKMsqAM4Ker0Vk1uv2wQNn8B4OtQ=
X-Received: by 2002:a05:6512:40e:b0:4e8:5f14:20fb with SMTP id
 u14-20020a056512040e00b004e85f1420fbmr747067lfk.3.1679400791122; Tue, 21 Mar
 2023 05:13:11 -0700 (PDT)
MIME-Version: 1.0
Sender: melanimuhammadahmed48@gmail.com
Received: by 2002:aa6:c341:0:b0:255:c92c:7c00 with HTTP; Tue, 21 Mar 2023
 05:13:10 -0700 (PDT)
From:   Melani Wormer <melaniwormer@gmail.com>
Date:   Tue, 21 Mar 2023 12:13:10 +0000
X-Google-Sender-Auth: 2ZCoZooHK5GhsOe62UxWY5to2jg
Message-ID: <CABx43vjjoVGqLVnWVeko8z03CT28-3iNaSRZNaWA-t7D6TMUOQ@mail.gmail.com>
Subject: Re Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honey, how are you? Are you capable for investment in your country?  i
need a serious investment project with a good background, kindly
connect me to discuss details immediately. i will appreciate you to
contact me on this email address Thanks and awaiting your quick
response yours Melani,
