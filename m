Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83B5F7E31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJGTkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJGTj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:39:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40B27DC6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:39:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h189-20020a1c21c6000000b003bd44dc526fso1498873wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=afUUSBRhezaQIIa/PqXPHMg3oRJPH6N9lA2MHCGelh4=;
        b=DXKWKNbw3ktneaE8BZzgJ8o1ien78MDtWtjoaxqEXV7h+mb533qSBvW4d73g1gClaG
         KNSfhN8+za7B6f5umH1m90hLz0j3XMC4GkK6w64P+Tid9RyizOWccxtnEt0AFFs3jty8
         gMAWL9LjyrXXQiu3BAHk+6p8FMzmUavwjqmn2Ups7GhUwYQabs3rEl0MNHdlzXwjdGte
         9NqqYktR1msC/gP/9RN/auFxIqkZ/sN9PXGvjcb8gXrycoT8iQoLl0Znq/ucKlSvvjaz
         oSihAX9GR6B4QvtuKyD/Ugg5OMdmSJSPesbxUbJZyZopKPm6i/Z5qd7Ni+KIz9fWCInm
         Qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afUUSBRhezaQIIa/PqXPHMg3oRJPH6N9lA2MHCGelh4=;
        b=y/qMMTiQbJaJ56Fn0F21LlPeDSsrgN692nNeBqRJwGi4so7kpAI/gyGHY6eebJYDKV
         kORXrPnBdajuNBCEpqi7V5dPjFsmpM0DPR0wBN0pjSnLDx97yjhL/5qH0w1j1Bgh/GNC
         Z1eVdST4X65/nJuO+BwlnAGpRKYKWYxihtw30Hros0bAzxrkQw19X4rasGy/FvGVUnWa
         TGKzpXhcW9iAgqav+G+SlYcDNXl6Kudu+e9XVQsDAHYYOmt1Aq02/yzI1sPOrSGPLtzx
         gRT+w8FYTt/TQWikI/H0c3s6MilsiwLvRlhjVvQP0wMd5YUwzSiI/+3eqkdEuQUawLo0
         HWjA==
X-Gm-Message-State: ACrzQf1SWoVdFTdY+VBz+fF+Kwg3LMRcBGNn6kiRieYRlV/O7dT/Y5o8
        ZElo2TXb88zmUx3lwBW15cVJ1yypg5q0hHxQX8o=
X-Google-Smtp-Source: AMsMyM6f+aR2C0vM+WFe+S5FBRclR+T2xxh51Gsn1tY65wc195blV3wnv2YfZH9MNXiMXPOYyiA08YIgMh75Foc7cqE=
X-Received: by 2002:a05:600c:510e:b0:3b5:1ab:fa5 with SMTP id
 o14-20020a05600c510e00b003b501ab0fa5mr11501733wms.204.1665171593456; Fri, 07
 Oct 2022 12:39:53 -0700 (PDT)
MIME-Version: 1.0
From:   Sheryl Robert <techdatab2businesss@gmail.com>
Date:   Fri, 7 Oct 2022 14:39:42 -0500
Message-ID: <CAEBq3SLVWk6WRF4dKQ-+0GDxmdpDq97g+mk0zVeWMP6bOCMMMw@mail.gmail.com>
Subject: RE: Dreamforce Attendees Email List-2022
To:     Sheryl Robert <techdatab2businesss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring Dreamforce Attendees Email List 2022?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts :45,968
Cost : $1,829

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Sheryl Robert
Marketing Coordinators
