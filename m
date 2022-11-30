Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA23363CD45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiK3CVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3CVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:21:18 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2B5E9E6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:21:17 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id v13so2574533oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juRVfNyoIGQSlG8so4jgNAO1W81kdptvIxICH3rKQwQ=;
        b=MDBaar+TyswcTRND6hd9MdiVDZEq1s0xUkxDX0tH29Ha47381U63s4Slfx5lduQjN+
         du/VR18/Ovx6D1pKKFIGUEIC6DudiSr5nVfMo8h2bhJ0K27yBL2dCXlGFpfXkMgBXENE
         Xg4aVkcZTezZ/Ahk7Llalwh5yo/wic+djs/jd5L50Kqf2+Dxbf0WTmnFp9mIsHEyCZ76
         nqQ+BSMm4umwtUODO7CZ0ObvdIGyTEP2q8QY/LOMbiZwqU5XZ+zDPoIDwIQOE5HoGjn0
         Q1xpp3yHAG5ep27/pgdr9oo1No60eAL/yEdn8axMyhimfHXB0F6k7ThIkMNUXDvbFnsL
         T9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juRVfNyoIGQSlG8so4jgNAO1W81kdptvIxICH3rKQwQ=;
        b=tJx7i9kvA6z8lWAap0sxH5R074WzMu4wf6F6yTg+VRpmUfhKEOFQm19hPFiVLeSGLT
         vGxZQhUvTsqhaCDi8+k2iHI7W6rm+BOzlDJ0HngWvpQnNoReR5vKR0TVmQWK7PK3Ky/i
         obQ7znbuG5gnh9md0h7nIapA9POaqWUHcX2HnWyD3l78HIftuFO6i40/vhz70liljcCK
         /0VxlXd6mPqxqlB/CA6BbDHTdBiBKNv81t0IWJcwWHRs7KsWeeH35MBs80MCiXzbS3z7
         jFnuMqVkDm9mstR9v2q4DL05XcS99IIASC8WFIKYPJJ8u+STkhZpJ/Q0CCpHAGx91PPd
         jr7Q==
X-Gm-Message-State: ANoB5pkc5l6zpnWXvyi2jElvSVHuXJsQb39yev4nwQ1W3J1BD2hJheLH
        vJrwWsDCVQL9UcVSuWNyeF0ghi8f6seh3cQ97bk=
X-Google-Smtp-Source: AA0mqf6HP4JMCVgjN5qMp3s70zG8a157bmDW/iwTD5rwXshjISCTZIY2uRT8VQISaMql6+oJV6B7+JY5QRUnx3XvWKc=
X-Received: by 2002:a05:6808:683:b0:35b:a671:ec59 with SMTP id
 k3-20020a056808068300b0035ba671ec59mr8339049oig.138.1669774876893; Tue, 29
 Nov 2022 18:21:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:9102:b0:df:7b12:45c4 with HTTP; Tue, 29 Nov 2022
 18:21:16 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <ayanounodo@gmail.com>
Date:   Wed, 30 Nov 2022 02:21:16 +0000
Message-ID: <CAGHdffNRGh0FikjTFnc5GzQsK6O_YiAZkNF6et4qz8AaC+gTcA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

You have an important message get back to me for more information.

Sincerely

Mrs Thaj Xoa
