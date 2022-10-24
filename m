Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340360BE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJXXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJXW7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:59:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A0F328AFA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:21:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so96036wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToEmPyBPUMd/06n/JjdTYAE2rG4ibwR5KTkv9jMk7uE=;
        b=c1kTax2Q/dBoFeAh6L1zYgAkyggMZKiM30othUlJNAT17NIHeX1otrI/8W1BWGjYde
         teFGa9ikjiOs/WBoA1fXwSBU3bE8u1r3D7i22ikRuoceIv8a59g5WGjHRH+n7NQr+uAm
         bPA8rxvz7FKk+r0RPdneSeJbqICWf6w7MDC3dKTn0woD+zXmScPkfAkNaJZi75+xGbAr
         dQcM9Hg56tXLKgfUkUUxZ0n6WKqgB1FfmcnFI1MlKSwnWmyzsDbvHcqGiDQDb78pnQEL
         No9RIzTGNad1e6euU9GGtZwyGbv5smeJbK4JJOkYqKkGB5p/1jIhFwOl3/1yXc3ymmm4
         wJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToEmPyBPUMd/06n/JjdTYAE2rG4ibwR5KTkv9jMk7uE=;
        b=pJNJrQkoe8Zx11O2eJ+3i49JPtlfYWD0rUILB7XPzsoI/xxui+9Lg1dZzadP8MqRTd
         +4O3IDk0bQidqilB6C2H9sDKM2BPJFL7GVJQQmFEvXrHGmClqnJTi1OLRieTKraK1Stj
         3tWLBCGAfcL41i1yd70iSYikFITcTvCP/HDaC2rMQ/y1aeXY+QCZ/ZHurf89XGLJd9u6
         3ZN5o2b9mYuOD+gOM90/KU3rFrnSNAsmcZHLHzee7j46nYAuuHgOsHyJoYpynZ5ff07A
         GkkArFOh4KEKknCMO8xzKt7qgo3IOgIz+sNqCE6j3Mm1Gs9STRHBat9GjSQHUDlaEXhy
         l26g==
X-Gm-Message-State: ACrzQf2IWVn/GufKZJfK8RS3YD6A/lBdvX4IWtOAXvMVbavl/Wd4aina
        2DuipZRM60mi8hAGdgBnSlgl0XwPjgBP1cOFTbaQaY3j
X-Google-Smtp-Source: AMsMyM7dFmF4llm9qGBCiw4Fr/G4UrW3RiVe4kQt6Kqq+cmZX0QptryaAdNtbLC+u7J0J+k8rjNd8Ohu07Ih4HMvJcg=
X-Received: by 2002:a05:600c:3584:b0:3c6:f234:852b with SMTP id
 p4-20020a05600c358400b003c6f234852bmr31113146wmq.10.1666646060945; Mon, 24
 Oct 2022 14:14:20 -0700 (PDT)
MIME-Version: 1.0
From:   Travis Geery <geerbot3@gmail.com>
Date:   Mon, 24 Oct 2022 14:14:09 -0700
Message-ID: <CA+mLQwA06-g0aBvvg3SFy4MY-S7fbaYG5CnLpGpO-JQS4ZwyRg@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe * tpgeery@gmail.com
