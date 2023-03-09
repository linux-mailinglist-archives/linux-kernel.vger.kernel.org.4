Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E56B2804
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCIO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjCIO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:58:09 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0619FFBF0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:54:36 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z10so1192642pgr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678373675;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SIgZooc/93pAzeV9rEKiA/tkDtEIs4wvyQZ5k/YNo/g=;
        b=INnCWLhZbAxWkWVnaztHOX1X39zz0JOnNpRwI7aG/pZvnc6Qd65aU1wtf7ZoYglYK7
         mwX/yUXZYdnn7woNTARMO7IeX9J6mgQA0ID9fSvRr2UgMgdASim2YAp69ttXfnM3iiJX
         UYUtQzVk6dp9XpCFrjLTvnJ5nC8HkUzJGydG4Sd0rU+RiwBcMYVJZJK266Bqk3Jqy8p/
         6lHj5M02jgA4hZYKoecOWSGfEZ/X/oXxo64MbkLaLUdJV6k36fZdMVvO6ZMuVab8iPgp
         xqCGg7a/vPrOQlbT6fHbWmhyzyYParLdq7dJSKIMDf9MceKJzNMYyM4oussFRbQmpRoK
         eTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373675;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIgZooc/93pAzeV9rEKiA/tkDtEIs4wvyQZ5k/YNo/g=;
        b=2i6gy2eD5/0TDI9P0wsOeyzdIFRb7F8wqWshQOZlHfEGRwtGBPb3/fQ/TmRIqxzIz2
         x9ymSFlJz7HPi8kgqcqd69lmeKkAGAzzo6vHKRFFqezjIF1ZAlGQal6iWbLrtcgoiyiU
         mMNa9sUu1CXJLpCoUP6y9CwEJ5T0+Cijqv0NuLWvFoL7ED0tsS9k7FI91qDLnGkRjeZ9
         cOatJGddA/bVQ48zl799fNAk7buPHdeu0gfxuNC3B2Uid7kHh0BitFEW1Jt1ujZpY4/F
         3P2M4zfz6Y2clTQWz8ZrSm683sNOn8Uw3VMKQvKZXxygWDSKcEdufLx8P2Ow6B+vZgn8
         oXoA==
X-Gm-Message-State: AO0yUKWDeBfUa6Wic1inh8WM92qVPLCxYHcPMzW+NNc1xe8tU538unMQ
        /cFWQzH3dH2noxsPYfi3KHL49Y1Ok+QzpFBW9VY=
X-Google-Smtp-Source: AK7set9N2EYjzdzHkrQTuvlmt8KqFzVjotcEn7wrqGELwfYAQkmiFX3qifbQexdkIVTMXgpjn/Wpkf0x+UhtUzpQj6Y=
X-Received: by 2002:a63:f350:0:b0:503:72c5:dd77 with SMTP id
 t16-20020a63f350000000b0050372c5dd77mr7999385pgj.6.1678373674981; Thu, 09 Mar
 2023 06:54:34 -0800 (PST)
MIME-Version: 1.0
Sender: sabitince.tk@gmail.com
Received: by 2002:ac4:9786:0:b0:5e6:f8c6:35d1 with HTTP; Thu, 9 Mar 2023
 06:54:34 -0800 (PST)
From:   Jack Mitchell <jackmitchell.lw@gmail.com>
Date:   Thu, 9 Mar 2023 14:54:34 +0000
X-Google-Sender-Auth: 0qaJAUviF8XLeJCpL9W0rp9N1XU
Message-ID: <CA+aD3eMtfBF2jST10v=DGWUtyfj9pYq2GX73wZ2Q1ehuADvGNg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj ,
Psal jsem v=C3=A1m 15.1.2023, pros=C3=ADm zkontrolujte a odpov=C4=9Bzte mi.
D=C4=9Bkuji
Jack Mitchell
