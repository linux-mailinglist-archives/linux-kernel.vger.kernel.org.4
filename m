Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54F6E58C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDRFqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjDRFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:46:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54979469D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:46:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c9so31337732ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681796787; x=1684388787;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+ZUuxUTAoz+nMDIAxIHUE5qjUM6hZWQNbOQhvaBX2U=;
        b=YM1Gxi4nf4u3hKthmD48kwT2HcET38kZsj/MDmN19EgRhgFs1AoZ4hTToWEktNqJcG
         B36UPzs9ytQtSJURYT+BcaAWECjcDj8Uc0juYo1c1tf7PTzTrIKGt1/Wj5lGT3c3wM7w
         FQEgAOsmyEgXekeIy5b3KG4/B5+Y+S/YX+njWes3CCoXxp6RcuCD9k292U3oknAiedlv
         odSmjEmanzr35tMNDA1+Ucc9wlRB2YeP+phsvG8ZrYjmlM/aMZTLPmzIeUgHfw8VVv/w
         mo3s2qcfua7Y46YjVdN/nSt9vhI0k45V5vupMOUY3niDbZ+RexVHUtinunWDlt0C77aY
         Jc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681796787; x=1684388787;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+ZUuxUTAoz+nMDIAxIHUE5qjUM6hZWQNbOQhvaBX2U=;
        b=V00liY8OXxAZ1FKHkUL8OALg6SMvXdlLN+fShGKv0KRB9rM8O2JGdLAHXrFkAKb1+S
         jNwMTEayEeo/VAePkK6aC7e9iZtsu7eJWJIl3F1tSYyEBIpqkKNLP8Yvks+DfzN+9QMq
         gmBJ1gq4Ip1z/Swlc9AOZKzvziqtKxUf4RyzLiE9vG67KqoT4Zw4W1YxS/CzcJesYmXc
         RJK8FcuLj3vo5FyIK7J1hDs0MP+XXm+00gvfZBbI99prExDd3BEXh7TtlZyFuadfJhFx
         KKbX5/LVmPx+5n1TFTnc6AWI4M6OK2Zxy8bzf4O+p5fVYsUBgTh4RQl22Rkuz+sq7iLy
         FalA==
X-Gm-Message-State: AAQBX9fe9Zr+SPPDaHQuxRPiaIuMjtTL8soXgs9UwfJOhiWmvcfPghd5
        GQPVZ3Xbo9274ZiFbEkNKKnBLXElj/yt3d+WwBo=
X-Google-Smtp-Source: AKy350Z5qGOafMgRdWJZ9OcKBs16h9RYXyPngG6urrpe9Ee7n7rPIO9uTCIYT/DU7/qIurdvtZV3KsrJ9pUYnaI8aCk=
X-Received: by 2002:a17:906:2c14:b0:94e:bcb6:aa83 with SMTP id
 e20-20020a1709062c1400b0094ebcb6aa83mr4882155ejh.0.1681796786763; Mon, 17 Apr
 2023 22:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:adae:0:b0:1fe:a223:45ab with HTTP; Mon, 17 Apr 2023
 22:46:26 -0700 (PDT)
Reply-To: ch4781.r@proton.me
From:   Bill Chantal <44444afr@gmail.com>
Date:   Tue, 18 Apr 2023 05:46:26 +0000
Message-ID: <CAJ4NGH6WpMgWt1zGRVQtqjPzM+joQaNnRXKPm3jKD61AFbKNhw@mail.gmail.com>
Subject: SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,HK_SCAM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SANTANDER BANK COMPENSATION UNIT, IN AFFILIATION WITH THE UNITED NATION.

Your compensation fund of 6 million dollars is ready for payment
contact me for more details.

Thanks
