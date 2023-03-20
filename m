Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03846C1FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCTS0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCTS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:26:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8C3E61C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:19:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so50440460edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336338;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVVx652hcMKMJrY2/TW3X5uhdHnpbhSboZxjUwpyCmQ=;
        b=U/43rak6Y1nyIk9nySuGfuQ3/OW8BVub30NrYtX+byxIkprGUOx92diqHjBltm9rX8
         toCueWzFF4Cq3aBjY40zA6wMZRuuTxeVQEWdqGgFBVKTAd+5QsohYS2BKYKJ2pdoKujb
         QvFqTBZczboj0sHibFfzQZ9ab+BwdtRTspm5R+oSqtCLwejE0I9H2aL+RAdD5d577Zpq
         bv/3H+yu9gP9TQkr3N6TvnAnQ6t+y0jvuYu+t9B6XLf6OKmWaMkAuuk4eEN8v0rA1QmG
         nyH6ONW5jC4QEu3bD/CxecyrScKdv2+7sM//xJ7mBVGnP98ghxQtFCBjdPjio8NChHXp
         5Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336338;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVx652hcMKMJrY2/TW3X5uhdHnpbhSboZxjUwpyCmQ=;
        b=AqSwRKQuN5IMJpSH8LlfjFsngSOhGuu/fWj7wA3NAxJM+Lf3b60YwEcMU/Ie6K0F9Y
         D5iCHV1qcVTWozvZClkt+wXy9R2KVYjnIcEZW39LPp1g6fpk72xoAj1c70Smdjtfr5Dq
         w3VnL+dYPb6XJmAz2r+JrHaEi+aVHPE5ZTVXEFUgjXmN5iBFEAH1nJ2OGujzrABwlSZM
         DGNh32mK342+T+mNazywXam2kytuJtePEq2r0/IZ18trsANaZ3yO58fOQ5ZSjO/fOj+6
         0FEykw2KLpU6JbmB9zCsZJrJTcoC8651Tt5+1iTkWbprhgDRGvP097sPjQU4QZKzx1zD
         thHw==
X-Gm-Message-State: AO0yUKWy/n9LO+VTT1pyfinMINWzdWCugKgC4oHMddOdMny/Zj10Qhqk
        f5VsbKwAjjYFCPoBdQg4FJ65fnP4lvs9hmj9xIE=
X-Google-Smtp-Source: AK7set/xFTgp4XqUH9jVB+Kr2cGKt+JEcJ/hZNMgxR+UaEFFot5QPHUm4QYkNtaVAgDn9IIVbBUVzWu93Ysoc7guinI=
X-Received: by 2002:a50:bb48:0:b0:4fa:4bc4:ad5b with SMTP id
 y66-20020a50bb48000000b004fa4bc4ad5bmr256112ede.6.1679336338313; Mon, 20 Mar
 2023 11:18:58 -0700 (PDT)
MIME-Version: 1.0
From:   ANNA MARIA <usatopdatalist789@gmail.com>
Date:   Mon, 20 Mar 2023 13:18:45 -0500
Message-ID: <CACe2vLXx3r-iFq44mm-b9g-n-4UUtM=DfDBPDVrELrv_FRB7mw@mail.gmail.com>
Subject: RE: Fintech Meetup Attendees Email List- 2023
To:     ANNA MARIA <usatopdatalist789@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you=E2=80=99re having a great week!

Would you be interested in acquiring Fintech Meetup Attendees Email List 20=
23?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts: - 5,386 Verified Contacts.
Cost: $1,326

Kind Regards,
Anna Maria
Marketing Coordinator
