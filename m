Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209EE62709A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiKMQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiKMQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:30:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBE7643
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:30:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so8575926pjl.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=eZmAIErqOnrhL7C8rilTlivxpxuzeOpPez1v707b40CzDVNLkuOu1ypXnZLomL5OhI
         8Q5jtryPMAk2b6MaXT/XxbI2yMxlXtssiq0/aXFPZPhosTppErvwpOsIzUVtdSgAjASz
         y2g0/YMZ9vLqc3ToTOQoigDJcCsoeP2eFZ45fBS1+9d6SKoXem1fe1wK8egwn5JFkiwF
         dF9avknM1fym8L8z9RBzMRPd6hA93o97R8MaOWoxe4fDwmb7Sybc4HZXabV7LbzPFJwl
         waHYn9OaIcTJ6M6sJzGM2yN6ygQkzqEgH6Kz1L4Wi3gHTNVW84Ac5h7qlhIkimWHJm6a
         rfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=61xWFB6LlSIDvCljcZKRI/w6wmeWl3FLMmAxBk09ECIX9mf5GO+UJaHUU2QPjrQ6CL
         tS0xMAt5dE8g1J37MqsSVfYDcUE2b/WtBgShBF5zaVZW+AIPR06+IzLim9g0Jc5i1Chw
         ltXx4tbYjYHuZ0DEjpcsXiL4OfXC4tbaMLQ1+UehaI3bqq94sL1YWZER3fGi+aYudJpx
         AyanZsnGBq65ZMgeLZ94nKRXEei6lXPTNIwNfPEiHE++o+aecD1HvMxigGCFeoyHu6oX
         /UjIpTszLequGHG4C5Xtp2SDNj4s5diyiFCIi7zUbWCcAIh3i0eILBVo0zXPekHnTGBW
         qpug==
X-Gm-Message-State: ANoB5pmaxcDR+sSkasLMWVveUtc/rpcazyoHmwUfeClFPnEkBRKGgMJW
        T1IVrVlDclj4jahWr35nHOoys+iDn+G+t+CLTVU=
X-Google-Smtp-Source: AA0mqf41cTZQt7mX79pc94BztKlgzZQTdlTsX/tdXNJlee9HrwI+UJM3HrcOrN0fibaeg24Z9F2mPSAAchtgQNxSgyo=
X-Received: by 2002:a17:902:e890:b0:186:a22a:177e with SMTP id
 w16-20020a170902e89000b00186a22a177emr10371465plg.163.1668357027828; Sun, 13
 Nov 2022 08:30:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:88d5:0:b0:589:82eb:58b1 with HTTP; Sun, 13 Nov 2022
 08:30:27 -0800 (PST)
From:   Ved Manish <vedm60013@gmail.com>
Date:   Sun, 13 Nov 2022 17:30:27 +0100
Message-ID: <CAGwWHSRFV11B2SLMzzkTNA8jjt96d_9R6dtQChLzmNMAo3bWZw@mail.gmail.com>
Subject: New message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive my mail yesterday?
