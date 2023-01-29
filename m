Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CB67FD1C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjA2GY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2GYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:24:25 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC651ADFE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:24:24 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bk15so23691415ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=iLAY4zAVctEiwhVJqfkEo24M84nLZo/Uu3xukT0KzIi0MeujLeaHQ+2r+gVl3i4sVj
         2AH6WL+KWwN5+TE+cFZM0ZPKYSwL0ui/q6wUOp1x0k7/FN9izICBwFhDxWnvMFPg57aC
         nU9O+V/YrhVWIxRqCfZtY8QimQCBxNdN763/my6UbthJ5OnD2pNuMtE0JpqMZvPlSjub
         rYxivKfEJn7VSqRg0iBtdI5lgU2ZIb/6+Y5LVxj+CPoL6TXcLeE64uAGgLI/yDYzEmRq
         5bzyRWTy//CLpKowIEl9zgDtR98caLTXuFbdNiCTwV7KgY753FnqTIMyiZtfv2PbLK3e
         +jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmYj+CB2YxZipjgrDEGrb8ZnVv0SQ/HUrSGEL3siE4M=;
        b=NG90eWWNEdTAQgQhbRitZ+nmoFC1NV60wewNmD/qJlRDvcRRJysGCKjoMQnlxRl1I2
         FgRvDxwrR2u/FfSIawCYy3iz0DRXhzyftOabqlu49uctLxPsCs9Hp/ObWKcwsHyjnY4d
         Oyj8oQZLjmqY8iXkk4DplJIUdaOOVcqNlCD05Y/XVOtlqOHshNB7yFs9m7Fr4Tj8VF/d
         qMRijuv0EscgIPqYw4v5NkrriBS8ZCJZqeaNMrcoqnhR3Dbjcws7IfPGfCK53roHVVRU
         5iOTs3Ez8SfWa4jVkDJA+3p1/fiUxfUISJsSV+Wl5HhA5DDhJHohqOASImrJjdOhanXo
         Ihbg==
X-Gm-Message-State: AO0yUKXhvz2qjnwCwGoe4mYZ6h08b9zEdy3ijOOOfRCvlUNEuXIIddL/
        UpT+UU7yfUyq6bfs4SgGwZVIYhicHZ09aZz8uug=
X-Google-Smtp-Source: AK7set9TyIi1Mglx4Ob1A8hdIxZ4I2MRnVzuU6ohP5vYa4TC5KZdtp7++QN+Z7yS5GdoHxPQAET6LmgANt1S9XKREJc=
X-Received: by 2002:a17:906:f1cd:b0:878:4854:fc97 with SMTP id
 gx13-20020a170906f1cd00b008784854fc97mr3524172ejb.296.1674973462395; Sat, 28
 Jan 2023 22:24:22 -0800 (PST)
MIME-Version: 1.0
Sender: mohamedazzouzi77@gmail.com
Received: by 2002:a05:7412:8f14:b0:b3:b4d5:70b9 with HTTP; Sat, 28 Jan 2023
 22:24:21 -0800 (PST)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Sun, 29 Jan 2023 06:24:21 +0000
X-Google-Sender-Auth: eUrtOfJAI8jhOybbXLcZZ9IUFc4
Message-ID: <CAC-Hp7tPP4uXPN4Wgkx6==mGsxN-7X7WmgFFqsHpDO9AYnoJMg@mail.gmail.com>
Subject: Hello Dear
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

Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share pictures and
more details about me as soon as i get a response from you.

Thanks
Ava
