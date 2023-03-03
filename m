Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216966A9037
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 05:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCCEXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 23:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 23:23:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C4717170
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 20:23:22 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g17so2054928lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 20:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677817400;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=Jr1wlCNowV6k7AEVC77JKUPcIJ5g/KKcQ2DSnbGWFj4E4L0rreRiOqN1ltJQTXzmV1
         Ga4Nca2QUn7k2M4moMbH5rtYnWkM0sdFmKyC66/nwd3kIcOHn3L/y+xHeH9YKVEoTC5F
         F9p+6onp0a9bi1aOHl1JQp4LglPt3dXVCfXqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677817400;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=J9IRe6RR6QjFHxQdfnLTT1dUGzwNo/Ew/KBdwc9OLLquxeHz9VCoENTaJJA2sizNm0
         DnEVG4gRIKBgJrEx6B4Gg15jN0+xulsIZ8ZJ0e+ocYhUMKL1ktZRmS8pvFjjirTzjT/g
         7mD4NVeSS+I/rBPvNCgOYegDvQpL2Wx9LfIHucBkWyPVn0TQ/qfRCiGY0gLDsRuzT3n8
         DdRt/vg2NPJuYHkJTNguaEFBKzh0+2jp4wlFpDHAYH9xy+Uof+G9SEMTsHJHNJ1AuaE7
         P2uR/QdTMiRfWrZmmjmSTWLvY4t7gBi1PzcHI18GsHPoq/E6LLfaYQJblMtdPyltCaEC
         X+iw==
X-Gm-Message-State: AO0yUKWP0SZXKKP0tZ2BoVongZSJ/OKpuHrzvsZYFL3bleHqfKg5OGiX
        8c6NHIZhcL4lf93RZok7WsHxuNdf60ogw8Q2g1N7Er4FO05IDQ==
X-Google-Smtp-Source: AK7set+l8ziKnsaIGMg+vcwQsfac8J6MAQ9P2y97uTX75VaKeOj7FYxwXW/gc1dfDnq7o0eE/ozYdBznaonHqZGwLQU=
X-Received: by 2002:a05:6512:102c:b0:4e1:dbbb:4937 with SMTP id
 r12-20020a056512102c00b004e1dbbb4937mr179253lfr.11.1677817400098; Thu, 02 Mar
 2023 20:23:20 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 2 Mar 2023 23:23:08 -0500
Message-ID: <CAEXW_YR4TBy+RsyjUSBOpKobKfTv2a+YkgEDgAUd3Y29Qpn3dw@mail.gmail.com>
Subject: 
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel
