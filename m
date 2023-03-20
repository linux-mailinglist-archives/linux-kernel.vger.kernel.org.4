Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84F6C0B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCTHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCTHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:49:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A811E94
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:49:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w11so5747454wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679298587;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IfpM4ChVlmSMiOjhRunbmWtdJ1rW4MbqLuM2qp48nxQ=;
        b=oIQgEds23IB0CT77z1qbybWa6l0Q9/qQCbqhYxVpdu6si+/tJkG6pswGVt4UfrfjCW
         21cvBSTUo2kvTDdNd3bYWODZr1o8c1b8EK1j8bhWFNRMhbbRQJYBScKqPL5lHkNZXEeM
         CuyZ1jqnKEF+A17uNDloa4Q1VrpGqRAoHxmJiB+dZ/b/WXBRyh/UzA0wopfs0+dA2tuT
         AFfyAotpg6SEWoWiYeYh85EFcQbnucIcf62VxrPidYXVAbj9ImxWDoL2ZZvIU31zaUt3
         w/yBoR1MpfgSqagcEkvAAUxbTtmfAhgwbZV08ZMULrSmaRTBafxHqfw4uahPpbFaMqIi
         OElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679298587;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfpM4ChVlmSMiOjhRunbmWtdJ1rW4MbqLuM2qp48nxQ=;
        b=oFE4jjBuaVyb8Gy3oX8M3zg0BRsCwH0SuTa8XBIkAqNV55qVX9Q44Pbi7VEbgQw4zJ
         j4PhXmH6/Vyw2rapov6p9bmCojfDS1PVKo4DLJt3IEUEub0mA8fU5GwEjTKyFcNHRJoB
         MR8agJ+2Pu0sQBKGR4XiMa59j3Ww3Ix+cgqrTILWPN1h7q86NRop62A81HUm1g3mQJUm
         qYYWp1058f8QIHqsZO2ewom6RIBUUe1AfOu1tV4g02Ljwkqu7CDIpfwLtf8D1GVT3WhU
         7vMCscV8PIeOEEFjC2rAgrISU5RLFtk2asgQRCoVT0qLOhqyRep3eibm91hTliD7FEp/
         IUbw==
X-Gm-Message-State: AO0yUKVscPCRPjQdeuNPm3nZFptPw+ULLlF6lE3OkLzQwTBn7XVyiPBI
        0jZ6wi8R52R5n1X5uNJhsaEfqX5ADRbX8w==
X-Google-Smtp-Source: AK7set9yNwg3NuHPFiuvAoEJY4hO9C0MvcRgqnlVGds88fz6+eJ3sXL+qyL+mJKqdu87Y5l9FV9Emw==
X-Received: by 2002:a1c:f706:0:b0:3eb:2e27:2d0c with SMTP id v6-20020a1cf706000000b003eb2e272d0cmr9206676wmh.1.1679298587624;
        Mon, 20 Mar 2023 00:49:47 -0700 (PDT)
Received: from [127.0.0.1] (178.165.205.58.wireless.dyn.drei.com. [178.165.205.58])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c22c100b003ede06f3178sm3572162wmg.31.2023.03.20.00.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2023 00:49:47 -0700 (PDT)
Message-ID: <aa775380bad70870d6cd17c178c2055c@swift.generated>
Date:   Mon, 20 Mar 2023 08:49:42 +0100
Subject: Re: Domainname singleboard.de
From:   Franz Steiner <franzjsteiner69@gmail.com>
To:     "" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sehr geehrte Damen und Herren,


singleboard.de wird nicht mehr ben=
=C3=B6tigt, und deshalb zur Feilbietung ausgeschrieben.

Falls Sie weit=
ere Informationen ben=C3=B6tigen, freue ich mich auf Ihre Nachricht.

E=
inen guten Start in die Woche

Franz Steiner

---------------------=
----------------------------------
