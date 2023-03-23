Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BF6C6C28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjCWPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjCWPT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:19:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BBC2B610
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:19:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so42499358edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679584756;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaZEaoa5Az+Owk9kP8S9MV4iQTC6KYP+QCYd3agTLNY=;
        b=UFxDmiB9r9TT3WkxQ85bzVTaMkxWLKraP3zrahrcBP9ms/Ii29CT6ScO7teb0qyx++
         HOZ0aCpmkOZpBdojA1az8iKZoiDVlXOsgFS2lXivGUNzczJXmdbE8+BdPpVfNpXwuhJO
         Te8lytSIpFms6/dn84FXiQTZEZHxv+xM5mAUkH1EtKBr9WS6NV6Ggz0XJJk28UGaGBmK
         3U8amZSX7q1MUoYfm4A9z8TBG8hh97CSvmOCF5bhgHGkuIEkaDgiwMoqONTWNRIRb6Fm
         1S7CA+54SOfIgPXAMQOJv+cb4Fcfx29ha0/6ebJPNYd7VYwrvr/Dqy/M14wMwBUfsYUY
         JqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584756;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaZEaoa5Az+Owk9kP8S9MV4iQTC6KYP+QCYd3agTLNY=;
        b=Ymfggpbb8Ar1B+yun/sOPFquU31PwsyFL173RXMnVzeJ144c53IcQfFgrQnK8VMbgd
         wJlouBTG8lFVdsw88OD5xN4pZKgBW3BY8OaX3eBanVGSAsiGmlWTBwGTkqXZUisQb4bl
         MYVHoTECVvnuMwpp/MFethowN8w7xaTpgul2Wm7HHU4mMO1I3M1KwHdmdKwhLvlxzWuJ
         YpL0L7qOy0ZA804rycv18KwD8y8jPuozxGibnTMhiwLm7cQmKRVLaqnOOLOPKFIbwQWo
         zywNMuCWkFPLalwx0o/L2/Nr34FpIuZ6eu7JnZcHjmZ+xd34PWLhPjfaB7leCH8wCXXh
         9UQg==
X-Gm-Message-State: AO0yUKU3rZMgRDnUvdxa29PVOkBlIebgiE41nIQZj8ToQlyVQzy+MdFt
        kamWPjazoEuaDXkKqam2Ea965fM36sODqHyiq4E=
X-Google-Smtp-Source: AK7set9xwMvDyL6YnEWCYiR7RN14qP6O+SaqCSWGj6SoNyMVnPNZVQUOJG69/AYRefahEUsu7eIrOx3plZh+yhj0wk8=
X-Received: by 2002:a17:906:1e04:b0:934:b24e:26ba with SMTP id
 g4-20020a1709061e0400b00934b24e26bamr5198582ejj.7.1679584756713; Thu, 23 Mar
 2023 08:19:16 -0700 (PDT)
MIME-Version: 1.0
Sender: geremiekolani@gmail.com
Received: by 2002:a17:907:25c5:b0:8f8:3cef:b21 with HTTP; Thu, 23 Mar 2023
 08:19:16 -0700 (PDT)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Thu, 23 Mar 2023 15:19:16 +0000
X-Google-Sender-Auth: oR5SmNFKtJEffGbl6qTDui80_cA
Message-ID: <CA+PxonVLef1wx6+V7UXboVsEHFhjfe7FWkz9j8SF4hbLuS9Phg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please,  did you receive my previous email?, thank you.
