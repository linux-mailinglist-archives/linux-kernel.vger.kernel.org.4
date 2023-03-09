Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852866B2CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCISTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCISS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:18:56 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078BA3B4D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:18:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id ec29so10604083edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678385924;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vtIQJgbAqYVFrKRDt53NZIcLU46fTuOZj8Pktv++Ns=;
        b=CQpdqMeCkaA/z738+UU2fGaN5/xdqU2BEwjNW3UtdOo0fjGYRWL+8yQRIJrvSOSsAY
         FE0fu04hYzhYHlRBePo7orOcrHQptX4fpyl/B+k6Ea7+qVO7CekGGV1XVIWW1C9RbFAV
         AQLdewzdyWSJQ1LwbOPDkWE79Ea3CfHFvfv2TA2OH8SfdnZBvxZHVdnFPGJNa0IL7VYR
         S2XW/RwFXi2x10DXo3bYFOKYjz8ddhwKSZyhYO5JOgFBEfTMcTO1eZBkao8pbXbPVuX3
         fkhAt/dlcPaHdpz2NBR2/cEVD4KW6hpG9/2Ux2HDqjuRZDisBYPR43UE9hq7/GHFqPip
         nnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385924;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vtIQJgbAqYVFrKRDt53NZIcLU46fTuOZj8Pktv++Ns=;
        b=EaSKnK0e1NonuaJMbXoBCxqYgID6IVV6vWtYRy3YfVC4Zkma3agqBM/hYf22ui8iqN
         2I3x+6C3Rp+TEO+xjP0P0ulYKwlOx//7xKVA5C9EAMnIpSskqDXct2XkqBKNMz8vmQH9
         ZFC22oddcz7chsn/TZc0KvXvK3HkxJZzFlCe2IByBzCLKpnBJQvKJLo5Ftqkx1iErSpO
         o+Y1O+9QUl7TGcndglE/IPcdrmi28Tx58cFvLTu0yNf//lgDM3jg/7ZeOA9n/dPomu4L
         eu+Zvnv+qOaZeX7vGSVKXHum2OBMCjwD30Lz2n0wB5HDWMREqv269O2N/uxmqsx1wJCS
         Bdag==
X-Gm-Message-State: AO0yUKUMxOMpoFbqCXwyOMOgdvyoD5WXLjFrVtW4hqNwP7p0UBoi1IGV
        VXRMgUOyhJbQ/KL41RS+e5pOikGoR3sOSh/D8Ks=
X-Google-Smtp-Source: AK7set8RsXIuhe+zqZlcmtgoO5ZNtkK2QN4WkgIrvcPHsX6Yw2MRHrie00YvsaWtcVMBMY11kWDdTDnMDlmrGjiv/x4=
X-Received: by 2002:a17:906:5910:b0:8b1:78b8:4207 with SMTP id
 h16-20020a170906591000b008b178b84207mr11837569ejq.3.1678385924251; Thu, 09
 Mar 2023 10:18:44 -0800 (PST)
MIME-Version: 1.0
From:   Lara Geni <larasecuredata@gmail.com>
Date:   Thu, 9 Mar 2023 23:48:31 +0530
Message-ID: <CAKDenP309B-vZN5AJRTRZ+PNDTwmOKhGEz9FnFPvw3C5E0GJBQ@mail.gmail.com>
Subject: RE: NTI - American Association of Critical-Care Nurses Attendees
 Email List-2023
To:     Lara Geni <larasecuredata@gmail.com>
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

Would you be interested in acquiring the American Association of
Critical-Care Nurses  Attendees Email List-2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
 number, Industry and many more=E2=80=A6

Number of Contacts: 12,639 Verified Contacts.
Cost : $ 1,638

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Lara Geni
Marketing Coordinators
