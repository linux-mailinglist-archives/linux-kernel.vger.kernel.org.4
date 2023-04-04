Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A926D6286
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjDDNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjDDNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:16:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E544BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:16:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n137so10334959qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680614189;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=IAk7M0RsTDH34xtFmXUxgE6wH3ey7SpP4cWGkEQ9m9YyAY0gcvtrRdUwGZCotqcliY
         BmOXRfpgO3Fim/wOq/VnLJIjr5ptSzxmaERJIWzxsdhRKUrzAC8Dl4t+4i4219yPMeT1
         9857SugLduPKA1dGm9YFOtS7MHDTXnX6hZ947DjPWWJO22ym8+/BM9utTD+E59kAIMWE
         WGhS6eCJt++uWRmeeVktGaXDO5YuCJamhV+XIcBVAXSy0GeoQPZkL3sXP80ZDWQ66OPf
         KyO7WPll2ZDM8gn8Vz6Rbz9P1O0EeftQjxi7VYkAwkbWC0pb6afAcHteCSuQwIkvG3BQ
         cnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614189;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/b9hSn8ZWObn0FlHkk+rwYaVaufISYusIZ7dspuZnGU=;
        b=U05GO945CBZoQr/jj+wCshSFFTNRIBv+GcHVox/hkjkw8C+jvhGh5xOWtYBsQux97u
         QhWOk5loddGafF6O79TKaFZw2atNBzSBPQCzCspwAz1wzeufmlU93adpoQlMzAzlvm+8
         vqOn2rS/FHjRWQe+v7UiiPVlzdR3zTf2D6jVtUH18wYwPnvz2VeUMpv1t3Tj8gt9OX85
         3fK2MdkdHTqWg0EHd9XOuzIFJY7gLaKFsuh2VGBld4Lsj3VcbCcsTvTjzU8C+TatWMuT
         Wv9SdO5itqDvDiWCpnbnZK1v7UyplN8oBDktLn8uPymv6iUtMeN6VVcby/394JLBNF1F
         +/8g==
X-Gm-Message-State: AAQBX9dK2cWZa40p9TzhP7lR2DbgqqVRgxhZch0ThzYKTEBSVDbuZSci
        DjMH8nNUlsr5bCQ8pJ6y1MIbpQVHdKYZ1PBx9c0=
X-Google-Smtp-Source: AKy350YrroNXMvm87dL/4cAXIdkGYjM+VggDP6JaKMoEVS3u7bYDTMew10G26N0ppjgID8lVQPHJZuXGPkIEA6G9adM=
X-Received: by 2002:a05:620a:1a07:b0:74a:505:b64 with SMTP id
 bk7-20020a05620a1a0700b0074a05050b64mr980196qkb.12.1680614189388; Tue, 04 Apr
 2023 06:16:29 -0700 (PDT)
MIME-Version: 1.0
Sender: alexsson90@gmail.com
Received: by 2002:a0c:e514:0:b0:5a5:ed4c:986b with HTTP; Tue, 4 Apr 2023
 06:16:28 -0700 (PDT)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Tue, 4 Apr 2023 13:16:28 +0000
X-Google-Sender-Auth: 6IC7Pz4TqfiaeVi42QNIfTrfFWY
Message-ID: <CAMJym1eggC0sng9R+xxAzdS8Bja1PBQKzS34BuA6w9wEYrKnSA@mail.gmail.com>
Subject: 
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

Hello!, Please did you get the previous message? thank you
