Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0311B6D41CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjDCKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjDCKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:19:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347040F6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:18:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r11so28743796wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680517136;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTKQ/iSroGJji6OTLa0a4XkLB3hdCJ1Pu3ohkR8aR/0=;
        b=HpVnnYLg8vDwkpe04kUQnwsR2xH9gmJ/49lxfgO5Qe6RX54QB8STKAY8/VRjpOf3A1
         1Zd8d+wKpMgAczGQ8EusATXiuRZgTzrY47v4Ts7rR+3Gj/XotCdz4Z/tSGRU5dGECvnM
         pH9/XKGvwMW4RLo9p56B9wJi0QcL51OXzQl3PsreEFwkghVcr5A7yziU9rPjmtB5ok+R
         kg+B5NHVpqJcwBDkY3tE1g3P6BVIayRzzhc2AMPU4cewD/ursXRlbuJdB7Oew7UGi8C0
         fVRA2f54mzXZPR8fnIXvuOjrtGlw95hhTAskPzhpSOVmhRqEigdpJHlvrLMlYN7FoLZe
         IRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517136;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTKQ/iSroGJji6OTLa0a4XkLB3hdCJ1Pu3ohkR8aR/0=;
        b=BxiuVkmXhQboOhPy3W02e0+j6tbOQRKGWd85Guw6PGyUMYpsGBQp7Bw5dfGxbPAL/G
         U5VY/PQVokQbua7ZQlKMs0AhE7mj5zGz1WEkHn78KHBprAjq1qnMMF1NeltM+ZEyplsc
         Ve21VgtRsc4sqB1g1jJyBsbzxq4A+g5yBevPEoJjlyKHxNitDZlyZkYqBPNuF/E8ODhD
         avObcPSeR23Et8Z/y1TcA89fGx9ICk6zR0Y8Wt1FmJ+brCOlM+z2UU/iPVcTVAY2M+XJ
         IVMJYlYba6lF/6McGhP767AMsv34Sr2dvuWA5V77h6yenokkY4WJUClsgIcGEmjpwUZ0
         2+EA==
X-Gm-Message-State: AAQBX9fKT6xKS6TRB03H+Q/6U9IthLug+V8h5arpbUN0CBivM0miD7td
        J6rhnRYdt//9YlhOjUz59PHXuYYUYzF1BwvHOoQ=
X-Google-Smtp-Source: AKy350b5ysGRmKwN3QiWdQzQYCUHlOkg1Jo2TN46TA7oys/7fb98dW8CJ3AU6EZzAmq8Vz7FNTgAknDKp2AzfyBKasQ=
X-Received: by 2002:a5d:55c2:0:b0:2c8:14ba:4594 with SMTP id
 i2-20020a5d55c2000000b002c814ba4594mr7259365wrw.3.1680517136301; Mon, 03 Apr
 2023 03:18:56 -0700 (PDT)
MIME-Version: 1.0
Sender: talatonikiema6@gmail.com
Received: by 2002:a5d:6b81:0:b0:2ce:36fa:c671 with HTTP; Mon, 3 Apr 2023
 03:18:55 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Mon, 3 Apr 2023 03:18:55 -0700
X-Google-Sender-Auth: 1Fc7cR6IEsTJ6B4WWaSw1sfEkfM
Message-ID: <CAALzGGiF_0u27gQGfGj8nJTEjnk3JymU70jcszHSZiaLcci90Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
