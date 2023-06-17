Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2373419B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjFQOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbjFQOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:15:56 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36319A9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:15:55 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-57001c0baddso19337857b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687011355; x=1689603355;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK8CSnpK/Lj4WgPXCAFjMD2+8ZPe0cG8Mxg2WoY+zJk=;
        b=iCjO1RaL5DUtjSHnjy9rZ1eDZEE8GOT0zEeBjTIPnxUDhma+mPuDXgi5VvqDMyfFM9
         jwvZPx6fS6S4jp2FUu2xVv1KEBr+q6aABixysdYvQEKGZ2W2GFQiYf+tAnZBZbP7eez+
         cbPyKFU+l4CwiLFcHoWDE15c16F0nwKnwQTeBv6woL0cnu+t/tq2jgtZlnR5md9KNvrv
         qhYdzxK8nWyrJAelcCWpUR2B0Z8x1u5UMELhcqCksb30Mo2iUXo1FfbyO1QGDAyvxnMe
         Few5PkY5xdtF8YYMpNWHGmxoatjkelVmHuW280yHGoFFEz12dyKpcIlS/hwk0HHEUstd
         UD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687011355; x=1689603355;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK8CSnpK/Lj4WgPXCAFjMD2+8ZPe0cG8Mxg2WoY+zJk=;
        b=JSZckXU9FCGl8fMBdX9QwH7YzaEXXvNcVUlsw1mMlRZoO2Tr5PuMpe0nsTN6poLIVX
         SQg/cBjFI1ybQF+ILfUvO4IfGI4DI2ESAyZhvYEdwyHZCES3TX3UIm6rrStEjpXz5Evj
         ZHJxw/gbkk5SN1KFHdKK2RMs/4/951sntc5Ca48amUzgBdzCpuMo+Ul+qO3EcSSXkHDJ
         /rY+nHboPQHDrISSFE/4YBDBRd0ril1yIJ18ImJ3UKhMdXcFv/AEtepZ4WvDwrUCB4Tr
         pxMQUZNitd9VXYmGmZQ8fy6FhhsgORzyHM1M+9vq2jbMu5//cSoDoSKa/TaQPWlDX3Wl
         E80g==
X-Gm-Message-State: AC+VfDxjgxnXXYxY4A6jaGpYpSa9ppnMXoikw6++0mtqBl2v0tntr/4r
        QaGIkH6aoOof0mWIeCi+XjqBo/GFQAANY0Wq9JU=
X-Google-Smtp-Source: ACHHUZ6K9/FpnnOiVsTNcgneVBQee2XoPPTd8J+XO2tWD4fuXHFh3uzGs5rKFqjd+TYjpllBa8AopIyiQZfpLsfP6Qs=
X-Received: by 2002:a81:8409:0:b0:56f:ff55:2b74 with SMTP id
 u9-20020a818409000000b0056fff552b74mr4936444ywf.37.1687011354754; Sat, 17 Jun
 2023 07:15:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:5206:b0:310:6f5c:ec65 with HTTP; Sat, 17 Jun 2023
 07:15:54 -0700 (PDT)
Reply-To: infoconsul03@gmail.com
From:   David Mensah <alannahnessa241@gmail.com>
Date:   Sat, 17 Jun 2023 07:15:54 -0700
Message-ID: <CAJX7a8b=6QgKxm_SYz8bfLWRp19hd9if3xS+sSA68MqV6QNHZA@mail.gmail.com>
Subject: PRS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello my friend, did you receive my mail?
