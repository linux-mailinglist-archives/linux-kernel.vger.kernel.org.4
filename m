Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0933F643603
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiLEUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLEUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:48:44 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAACF309
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:48:37 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g7so1020610qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newo-com-co.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:reply-to
         :from:to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G87DnUAiii3iK2ESprf59SrkRQzux29Sco0voF578tw=;
        b=vCinPglihYKzA3+rfmPD+/Zj8GjRL4f8O8AcQ2DPTe+UyrkKtumWqWXXGjLCjIcMG1
         HoKivAQ/s6B89skCvd8yf6vGn5qYyETv/EvE9eKvBqQXcN13HlKYolJLszX5JdDjZ/AD
         tna+bKU8mN5Zwr5EBhBCW/pm6UqmO9yi41B/zzlwC7GWZxbN7+KnIy8MAULtlctLx66j
         O9YmS5+G7IXMUpe2lPqywxtlqAnRwwqyDK2kjpdSR5Wtl++nE/2zd+EpXoML2mxCwBgi
         2QQStG+0lLfptRX7v2tDFrN+27lnSjBHw4MSnsfUj3/m/xj2g1VTyTxSQy+FlxOGzUI2
         TK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:reply-to
         :from:to:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G87DnUAiii3iK2ESprf59SrkRQzux29Sco0voF578tw=;
        b=eFnl1OJruiPIVUddURTlhs4esTiG3Im5eyEjHHh7SLNI4NirIQq9sHAooUgKa3YmZP
         pJnjMPLMXro9hT4LeXszPXMZoREOt7x2nqLo+yZ2AknMu/grTFLnr8YMN9YIRZshmepA
         UTQTnQ2PYG5C/7ViJGFd2H0cvRc8sYHWtbFtkGxpMj0A6LvaPgM3SZie2CUH5TDfnPCh
         EJdiE5jAcXjCZChyf0CYQcUneIR9vj15CeqYOLmWj/NLqMA3Zo8AoNsVWjQ+TNfWhp6c
         lh307B/iFtX4+YEzxzTpPjnSHEBozw6rOztW+M6GR+RL+tq1MLKclsuQOc79MqzFlRjZ
         OITg==
X-Gm-Message-State: ANoB5pkKp32FJizSV1HK9CqSxc0SQSx+PU4VdQ3eYU0INoG7EnChB33p
        eprlS1ODfINh2zhXO0okxzNAyL7Y5eYotxPqGPI=
X-Google-Smtp-Source: AA0mqf4ST/PpRiSTcSR9DFMMezeG5EMF6nB0xhWX1gmOvhyP+BqxXKJB8O3OcEhtD2RTBA/jq8Ee8g==
X-Received: by 2002:ac8:7fc3:0:b0:35d:42d0:25f with SMTP id b3-20020ac87fc3000000b0035d42d0025fmr62092965qtk.18.1670273316818;
        Mon, 05 Dec 2022 12:48:36 -0800 (PST)
Received: from www.tucolegio.co (23.220.167.72.host.secureserver.net. [72.167.220.23])
        by smtp.gmail.com with ESMTPSA id k17-20020ac84791000000b003a50c9993e1sm10371915qtq.16.2022.12.05.12.48.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Dec 2022 12:48:36 -0800 (PST)
Date:   Mon, 5 Dec 2022 15:48:36 -0500
To:     linux-kernel@vger.kernel.org
From:   NEWO SAS <soporte@newo.com.co>
Reply-To: =?utf-8?Q?i46=D0=92o=D1=82=5Fo=D0=BD=D0=B8=5F=D0=B4e=D0=BDb=D0=B3=D0=B8?=
           =?utf-8?Q?=5F39914rubl_https=3A//telegra=2Eph/VN-861378-12-03=23?= 
          <linux-kernel@vger.kernel.org>
Subject: =?utf-8?Q?Copia_de:_2mb=D0=97a=D0=BFo=D0=BBy=D1=87=D0=B8=D1=82e=5F=D1=8D?=
 =?utf-8?Q?=D1=82o=5F33239rub_https://telegra.ph/VN-84335-12-03#?=
Message-ID: <ccc03b6a11a52ecaa9dea9abdb9d8a23@www.tucolegio.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Esto es una copia del mensaje que envió a Servicio al cliente vía TuColegio.co

Esto es una petición de correo vía https://www.tucolegio.co/ de:
i46Вoт_oни_дeнbги_39914rubl
 https://telegra.ph/VN-861378-12-03#
 <linux-kernel@vger.kernel.org
>

5p6Выгoднo_зabpaтb_11837rubl
 https://telegra.ph/VN-341581-12-03#

