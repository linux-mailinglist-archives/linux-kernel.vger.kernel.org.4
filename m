Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFC6A2EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBZGtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBZGtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:49:47 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C079C66E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 22:49:46 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so95375127b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 22:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84ZxZDsqjjoBQGIs/TPrIqeOtX5LTOZw9MIgowwXHbY=;
        b=bPmdsUEVvYMNUv9MutzT54bXpP6Z0OxmaTdmjKVuZdKzuw8NZcGt9mGLWv9yS9zLVI
         oVBYWIPz4fuArTvtESZ6ICi9lze0nYnd/HAiFEZ5b0XVUquEPdgACz/x9n7flazXUP9W
         231T3RCBLM+aWJfvskPhjBMaFat6ry0NbI8+x3wkts26qE4gTJS2fQAAXSBDICjj2e/H
         fq04VriAdSyutL47k2Feps2EyvgY/RcUgUl4j8G6p7o2a94ImO8aNw5Fgp6i7FJhDaZN
         ph7d2CIsBOk4cW8pOo59SA1zpYW0SznqCBq4A6tpT9rbN3QtLh1z5KD7OPFIvO+JfUjT
         QX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84ZxZDsqjjoBQGIs/TPrIqeOtX5LTOZw9MIgowwXHbY=;
        b=rgIU9xrjZK65RuZSlDWZPBr3rOvsYQlZX0bR5OW6HjWGsWE946uEDeRHYahHYNbMf/
         OZ10jAHyOT7MWkZThCQbznlGSjhKyfFkwSOqha/OQQsPVYoq347O2h/qWTFYfrFeV2mO
         Q8O5fW2YSnnTBJwAXHFAqma2PB8XUShveEhQMsx4Vxyq245eArQvf3hPwMOjR5aBGczZ
         eA5Y3OUrDb58NmF/nnFIfW6OfbF/sD05Myjuq82D36+PK+jX8FuYEW5BPH08X8nXHNWJ
         6Th2amVFWRbrl+dy7F0Gg617FqUbf/IGNWS6iMZwjlPhGmOLH16qDMueS46MbaPm+rm4
         aOLg==
X-Gm-Message-State: AO0yUKVSL47WW5TrPVXd5kCtnnqEAGx04PdsJRmwjZPhNv702WSw104j
        MbV/Edh2Z4G1IMj+did0n05EPjISwdxwuAH5fJk=
X-Google-Smtp-Source: AK7set9Drr7Mhs8hnk/KYfA7d6o+DuevQu2sm6WsigUU9wzqyQ7595/v8+BUqVMgaJGJBVBgZhtpMaPgC1ubI5Fdjxg=
X-Received: by 2002:a25:9392:0:b0:997:bdfe:78c5 with SMTP id
 a18-20020a259392000000b00997bdfe78c5mr7150452ybm.6.1677394185376; Sat, 25 Feb
 2023 22:49:45 -0800 (PST)
MIME-Version: 1.0
Sender: seydoutogo515@gmail.com
Received: by 2002:a05:7110:b104:b0:1cc:99b2:bf45 with HTTP; Sat, 25 Feb 2023
 22:49:45 -0800 (PST)
From:   Mrs Suzara Maling Wan <mrssuzaramailingwan12@gmail.com>
Date:   Sun, 26 Feb 2023 07:49:45 +0100
X-Google-Sender-Auth: nePFH8ZBjEjOZWhmQlarz3ocy0s
Message-ID: <CANChiWts_dqbVSp0=Fz8Rg8LScFBiXr_5xexXTBQQsvv+NE3PQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Beloved,

My name is Mrs Suzara i have an orphanage project to accomplish in
your country to support the less privilege once, can you help to carry
out this project on my behalf presently my health condition we not
allow me to carry out the project my self, now my doctor has already
told me that I have just few period of time to leave because of my
ovarian cancer disease, can you help fulfill this project
