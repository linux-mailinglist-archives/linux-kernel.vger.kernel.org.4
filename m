Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF01B73D12D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFYNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFYNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:34:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ACD1B7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:34:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d8332f50so287122266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687700052; x=1690292052;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT1RnqwHvj1tXJFjyRYSdQKzWzs7kT8eKVRlXXs5/9E=;
        b=YEJLT1SJGObonol5CK4CTVO3r+EdrDofH7+Wasw7GddTeGWHW+1H4maIxIfITpbw0R
         q0mg75Z2MddEdCRyQNbCGukxrvq06ilRZz5GZs40nSPfeP6HKuIIDcImCpRxWAtTc/2I
         n55BMdvaYZJvod3lmT3NMZ4qt/JjO8F5o1nKcz+f8WrtrYNTj2jmkhfgQrY+o3E80qfH
         1ADLOjCfyVYrTDFzV+SxFKz3XDnX3IndFeY5JzuYRQs/DyWk1FVntCm04UTXWq6kl5xe
         1Ej+9AqiOWH5VOrgvYpvvxBu1KYAzwlGoGS7bl84ubS3krjyLQe6ddpz8yUV/Jm8I/Y9
         Qggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687700052; x=1690292052;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT1RnqwHvj1tXJFjyRYSdQKzWzs7kT8eKVRlXXs5/9E=;
        b=ONMZ1u+sHyEQd6fwW5yMUWqf8uzDayI1M+R10LQgltMmUvdYctEDh5pyM+LQD26KIU
         HuTzkTiABbMemcF12Bo3X64FU6NuaLfxNkqQYWidbp61glE5bASwSPMoHWMT+lVy5QOf
         aTTX8y0Z/PklpfIwFHYM6kKvMvOl8VIB62rgsp8ttEkYIP68nWBYrBXk5GYvI0/xPvTk
         8XA+p30G8jvYUmF45kgns6tNplExS44ynWl6uVv7N0FDtnud+K6E5YEvoIcznqxvo+oS
         +CEQ844RlE7IKir23AVKMoAJH8hcCgdqzWj7Uxu6QUYRVKik1BnZICb6YnSdXDy3ppZY
         E3BA==
X-Gm-Message-State: AC+VfDzc/noDDbZnNMV5fdP/Y2n3mtBNXX8NKytb3g526/K4tugDjJbr
        3SAXwVakL/qPxtGFFsBQDDM=
X-Google-Smtp-Source: ACHHUZ4Nk/V/R5Gctq/qaYIWSoMcpVdzZe0+WHjLEEtR3lHMbZw08tT5W18d5ho2uHRKET0UqGpp+Q==
X-Received: by 2002:a17:906:db0b:b0:982:6bba:79c9 with SMTP id xj11-20020a170906db0b00b009826bba79c9mr21353854ejb.20.1687700052358;
        Sun, 25 Jun 2023 06:34:12 -0700 (PDT)
Received: from smtpclient.apple ([2a02:810a:9640:26a8:484f:5091:3ba0:ecc])
        by smtp.googlemail.com with ESMTPSA id n15-20020a05640204cf00b0050bc4600d38sm1766070edw.79.2023.06.25.06.34.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jun 2023 06:34:11 -0700 (PDT)
From:   =?utf-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
Message-Id: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com>
Date:   Sun, 25 Jun 2023 15:33:59 +0200
Cc:     eperi1024@gmail.com,
        =?utf-8?Q?Franziska_N=C3=A4pelt?= <franziska.naepelt@gmail.com>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        philipp.g.hortmann@gmail.com, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
To:     "<gregkh@linuxfoundation.org>" <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_B,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback :)
Since not all the patches of my first patch series have been applied, I =
thought I have to submit the whole series again. Submitting a series of =
5 patches, where 3 have been already applied of course fails.
So does it mean, if 3 of 5 patches of a series have been applied and I =
want to submit a new version, I only submit patches for the remaining =
work and not all of them again?

Thanks, Franziska=
