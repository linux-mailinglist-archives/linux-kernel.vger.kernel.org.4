Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB45F3155
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJCNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJCNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:35:59 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B72CE39
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:35:58 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1326637be6eso3251612fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=yjkMwuHj21MRKuadu4B+5pAvLHiSJ8f7xGe8NtxRR9I=;
        b=UnfI653RvUwITG+s1ivDH0tCE7588aExpTkmds1fkgGZa7xDx/1jgqePGpMnzDQX1C
         V+H/54LbIWQWa2QDE6Hc/DcSumkQPjksPVl7oRfuZjCpsp2AzutZp2Bhyd+f55XFOC8x
         u+ldUfheCKtasuedlYTt4SZpQ8Xe982gZ2Etwzy2PD9l36GxNlIfcom4PcJLh7832MQn
         vJlaC0lV8glqd45lWmwyb2ohuE6t8Q4IP7IPlu2JXiYJ7kQJ6DmXukOQLyvPapNQShKo
         wznaHyiMx2F+BoNaTUB/4zyWwWwrRADW/NHTkUj3r3v19PbtYa++rZ5IZeRledB3ZhCC
         R9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yjkMwuHj21MRKuadu4B+5pAvLHiSJ8f7xGe8NtxRR9I=;
        b=BIIJ+94RnwzsXDaR5Shb0UXHkdAqscLhE/D4bH+Jo+rALP3+B9jXYhozAzf1jW+jfb
         lD/KsCB8tGFOsUqmy1KulKnlJ9CM4o7eGFDWf4+pHROe72Ea1VRZJHTSVaW1neP1Jvtz
         aJsiPuN6F73KddBnMv6jmxycj8koim8HrZ7CSqhYKQAbaxTDTNpMJk/YpICboT6rpBiN
         s/OajMM/UtYMF/JIoxBF7LmDtgMJXr3pT6549BGh28FJx3RP6cV0d3UPtJfzn9xzf1q9
         STS08Ce/bAjfYRIIPBzPWwHe85dl7D9d5Qaqprko2dWdrQzLgihVFwh8D83qN0xfSLPu
         pPVA==
X-Gm-Message-State: ACrzQf3haBcKtGgmkdAepLw78B/bAEOYaGIwfXKyWL7mIuoZi6RaELMM
        6P3o0DvLemsZdOyWJo6/LaBsCUxGIkkQObQd7xFv7Hds4l7hCtcK
X-Google-Smtp-Source: AMsMyM7/V1s3FK5jknd8qc3UWmzt0hP9MEdoKxcd+Dc5XYfXd8Xtjsn6qrJUYW2USpKW1deZvuiEqXrj7u/21b3T630=
X-Received: by 2002:a05:6870:3485:b0:12b:df60:622d with SMTP id
 n5-20020a056870348500b0012bdf60622dmr5332706oah.25.1664804156335; Mon, 03 Oct
 2022 06:35:56 -0700 (PDT)
MIME-Version: 1.0
From:   Carl Dasantas <dasantas2020@gmail.com>
Date:   Mon, 3 Oct 2022 09:35:45 -0400
Message-ID: <CANNVxH9biW6OYNFbF7ZVvSBCk4+1RAWmgjXA9Z55uCntrRasbQ@mail.gmail.com>
Subject: New Longterm Kernel before 6.1 Rust?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning everyone,

I was wondering if a new longterm kernel will be made prior to 6.1
being released with Rust support added? As the kernel.org page
https://www.kernel.org/category/releases.html states "Longterm kernels
are picked based on various factors -- major new features...". In my
opinion, adding Rust support is a major new feature. Of course it goes
on to say new longterm kernels are dependent on time, etc so I thought
I would inquire. No harm in that, right? I'm sure there are a lot of
others in our community that are hesitant as I am with Rust and want
to see where it goes. It would be nice to have a recent longterm
kernel so we can see how this Rust stuff plays out. Possibly from 6.0
or 5.19?

Thank you for your consideration,

Carl Desantas
