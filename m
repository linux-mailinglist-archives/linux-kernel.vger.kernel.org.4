Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9350B69D0B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjBTPeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjBTPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:34:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6899
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:34:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id na9-20020a17090b4c0900b0023058bbd7b2so1724025pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676907255;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3B2Wi/wrUBUhkwFj/RrP6RgX0CW0xuP0+qvj9sQqmI=;
        b=HoDNrCfSnyJ5gM+/G4O4j6lFtpSkvK+ZXpZbbaGf9espLHp/kpav3SwyvnSJ4xIN1E
         l7z2OLZAA7bkWhWDdekB9S7cjIQG0fTgqDGxcmPdYoCTUm6IqRRJTNez/yoOI9WO9gGK
         Ctzwv8h0pC9rZ5tbrzvFPhIJaZDUNbBqOnFwXnSK0qDjYBEvm1WHLmxagk6mBKCyIUFa
         jUbCMCOhCb742WwA5zVrHVK9T/1jiq6ycP+LIeNhwQV6b9Dxs+xplOUWBYjW9/Ob7J2M
         L2Ox1juwtd65IxZwmDFRNTiqSSM+Ebjx6ntw3dDR5OsgXMcEciJmcBz2CimPVsUaoEnk
         RUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676907255;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3B2Wi/wrUBUhkwFj/RrP6RgX0CW0xuP0+qvj9sQqmI=;
        b=j6DZYPI0SIM6Zegmw0lLM3XLTe/lwjt6yY3mwy6NONUzfwS4M7vbNiTruyr+HsRL0n
         uIL2JaqRpot353ZogFwhwVDH0ipM0hwRMxnVug6IKvUpfExpcvds9BuTeKKN0dYEiAmP
         fn6/IyUabjlFgn563jXeijtWJMQZ/N8yxofVs6aEK/NB31OMJ+RbzuwYt45gNuT3F0bu
         HTO8rpVpO32k5j3xS/g8TYHxjtgrpgp9khVjxDReqL540AZM0td+CcnstJg7/EDucYUE
         ApjI7JfkgNBGRnCJHuhFLHWfFUqCDhyxUkpyttUMWtBZ+EqDNTKfXSHMZwXvY+dBPg/L
         vfjw==
X-Gm-Message-State: AO0yUKWVbNtZf6fDEok0Jlzs5oZC3/z93EDhl2NXsP6xlxMb9hK+CheU
        YQy1mJ9YF5QHDs2JaiHWJ1Ykpo0BNTZDJoNjygM=
X-Google-Smtp-Source: AK7set81XeX36TAUt64pzAWLnH2W3tGIABMSSv2QQO69uzb1X46lEj4Cd3ldyCKReaAquFdk9Yrz08cQRJ6NMiEuNnI=
X-Received: by 2002:a17:902:ce89:b0:19c:3296:ece3 with SMTP id
 f9-20020a170902ce8900b0019c3296ece3mr510103plg.3.1676907254987; Mon, 20 Feb
 2023 07:34:14 -0800 (PST)
MIME-Version: 1.0
Sender: augustony201@gmail.com
Received: by 2002:a05:6a10:e50f:b0:410:f76e:ff13 with HTTP; Mon, 20 Feb 2023
 07:34:14 -0800 (PST)
From:   "Mrs. Peninnah Ariel Benaiah" <mrspeninnaharielbenaiah0@gmail.com>
Date:   Mon, 20 Feb 2023 07:34:14 -0800
X-Google-Sender-Auth: M5IrrazDnzk-OKgA7Fy-poH0uTk
Message-ID: <CAA6-=pbU9TrpB3edEpQDn4b6FJ553ROUOS0+ywQ5AMU23KyC5w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Did you receive the message i sent to you please let me know
