Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1560FA42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiJ0OQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiJ0OQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:16:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C54317652D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:16:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y4so1639213plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=fMhQ6pNs4abAZzuwHxLo19NkrtLsH/IplcWUUk5/FlG8rlHxJ2T0WFWaFzIfcWyEsf
         rtQtz142bJ4t7Nm+zYeEVhVg3sgbKQ8v9uc4tgrFXEhbHyqsz/VG/g/guM+BextkAn4c
         d9PXFgcR90gU5FghK55nUUhk5/0HtdQwjTkvKEvYoW6ZfgdiBeMqujzChumXlIaWgNkh
         bPuB7TXJzeBAdgGU0j/1aL8xRF4rxtVK3Yz1eWh5zSD/MnjVfw1DXaRfM67A1wTReDlF
         AI8Jk8dKiPCVUYehDuv7AT73esTyDnPDZVEER0xAEFICRPNWLZFYDhd8sgp8/i6LPeNW
         8loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=tF7K70CdiO5UPwAEkvBUIlSSejgzGn2MDmgmxW4/vsxFD64BpAvRrLYU9QHQqK6+WY
         bq5aALSpHaDmKUVT1ZBN8rcy8kIb91GRswLuY3biH28DJx2iw2SlbdhdX9gE+svzc9L9
         Lv+X/Yexq2wqeWf4/+MecWGFprE+SsNwKIwTC/kNLS1agIBIiHLuzpkuNVC+pDqCJ5SI
         e5E9ZOjJX8zi/A1cVysmJ+7EXB7ThyOsNyq9wS8bURWzP31N+eIwQh8Ox/bJ4jlvEXig
         vOf9T1s4xnSCj0u+VXErEWLmA+EIJkFOWLJqs4dZ8L2N7aPpXDRSi8vWopHNaXc746p9
         EEDA==
X-Gm-Message-State: ACrzQf1s4hP7WWEPqrqqezIqo+C+Vl0jDA/7dSUaaLjHL2UiWuHjarT4
        6lVED1Ezyo+6U8N0FKGxp23k5S4Nf4Fs6MgXM1U=
X-Google-Smtp-Source: AMsMyM4MSrdf0SpY3pQYO3YCiRlt0A+xnAtmzgloRJZtxjlRzR5nxpWWqPw/7XeFtWnMWY259B+qOGu87GBD4gUuhic=
X-Received: by 2002:a17:903:2346:b0:186:ba56:f520 with SMTP id
 c6-20020a170903234600b00186ba56f520mr16549796plh.138.1666880209629; Thu, 27
 Oct 2022 07:16:49 -0700 (PDT)
MIME-Version: 1.0
Sender: chrisdickson200@gmail.com
Received: by 2002:a05:7022:63a1:b0:46:10af:bb83 with HTTP; Thu, 27 Oct 2022
 07:16:49 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Thu, 27 Oct 2022 15:16:49 +0100
X-Google-Sender-Auth: zIDy9SgQ5xzYYHjheldjB_6PFs4
Message-ID: <CAHw_d8ZzyhkUvDhBjvfKpFtpwe0GtYF2N+oNYcSn4MdQtnHHCg@mail.gmail.com>
Subject: reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
