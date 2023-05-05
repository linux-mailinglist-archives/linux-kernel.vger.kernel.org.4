Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D96F89EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEEUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEEUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:00:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15652E7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:00:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 3f1490d57ef6-b9daef8681fso2033236276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkglobaldata.com; s=google; t=1683316842; x=1685908842;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4S+BQ135/dNBmy2+J9Z2TIXgxWkBzgmL3h/7JVV4Y3I=;
        b=Nh+ubL5l6GrXyqXZzSZCWu8Iqkb2Q9BUCvttpBRoJMN8lrg0mZi7InesAvd4S5kqCr
         qhf+VrGTAETDdU0ejnjM4Xm3jm9VhMEH7uFtFsRMqB+YwRlI/1AP7oZwcm/x508GnRh9
         nIIjvUzcVxWawA6PDh6aVi3dLCkiwsGl8DYTfzAKYloNxmt/tDK3TAxbDzEX8awX98Ve
         1+aZbCsCt60rxixFm5/nSNW1vRKbmuQ8DwjWxi1GUhMgR7kRZz/uT8T/AFm45lKSNJt3
         /LrEtnnPHTjiKXwMsakpCW+P66H4yyCxKO9hnlrKvveNXxTauEtkxUl9ZVf63PuIy6tb
         Jgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316842; x=1685908842;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S+BQ135/dNBmy2+J9Z2TIXgxWkBzgmL3h/7JVV4Y3I=;
        b=VMUf+xuA1DGLEeKWUp+Sqk8xzuxdlU8RBuJ/OcusTD6OTS6ns/8N4Lwh5YtZLTZFC3
         XVUGfo0JH7ChSv9bykoQQUSr0YQr1PIEXnTYirJA85MuQTgFbDk+QppzaYuYjIW9F4qq
         8hr/VycVsptwp3mMhdT8cR4Ml1KcyhqY8wfSOrOgNVmj9xB1WB8eawokQo2oCxFURO/X
         gSdfUwllqaC71bB6+7hy6wyhFovg1KxopKgwrJToxPm0qwFaX8lfG7b5D08JVEP5Eo7v
         cAQQVMma5nITxcIW8YboLC0cFz81UIfVyJmKA3xcOOzdHxrPFzgX2YlazpGw6fM+a6Hi
         AxFA==
X-Gm-Message-State: AC+VfDx2yAgKdsvsGTNcU3IbWuCHPMPfyg3F8/JpzXxYNiwtoNrbn8st
        NGHze+QlKQwDL/x/trIlXBS3DajxioxGNmT4OUWp2w==
X-Google-Smtp-Source: ACHHUZ4a9gbWeN+/iDrHX93NOU1qXaVNuP1OAqu1KJeLed1tK/1j72UO910xIN/ldC8WAePB6uzutOkiNZt52aUxtlU=
X-Received: by 2002:a81:6c93:0:b0:55a:7c7:cb7d with SMTP id
 h141-20020a816c93000000b0055a07c7cb7dmr3168523ywc.28.1683316842233; Fri, 05
 May 2023 13:00:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jennifer Davis <jennifer@thinkglobaldata.com>
Date:   Fri, 5 May 2023 15:00:26 -0500
Message-ID: <CAKDU+p5r-3S2KYEMJ2VZHTb7XykHF1Nkc=Qyz_FgBpx+Y3XXGA@mail.gmail.com>
Subject: RE: Gartner Upcoming Events Attendees Email List- 2023
To:     Jennifer Davis <jennifer@thinkglobaldata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring Gartner conferences & Upcoming
Events Conference Attendees Data List 2023?

EVENTS                                                         Contacts    =
Cost
Gartner Supply Chain Leaders Forum              5,386       $1,379
Gartner Supply Chain Symposium eXpo=E2=84=A2       6,267       $1,379
Gartner Digital Workplace Summit                    5,899       $1,379
Gartner Marketing Symposium/Xpo=E2=84=A2               5,586       $1,379
Gartner Security & Risk Management Summit   6,369      $1,379
Gartner Supply Chain Symposium/Xpo=E2=84=A2           5,456      $1,379

You can acquire all the expos at a discounted price of $4,989.

Interested? Email me back; I would love to provide more information on the =
list.

Kind Regards,
Jennifer Davis
