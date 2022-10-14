Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3325FEFA4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJNOD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJNODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:03:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB596AA3E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:02:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 63so5712018ybq.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=F93ZykcWHmnDYfMa5E3d2TdvbidqgIEX/1hQHMkybhoDkVjW3ZNaCYSZJMwdAOfCSk
         dzuiqRKbbl/XMk8xRlnPh6uIsS2BHw4vYzs2GJ+r+nr+94srQP5sVqsnW7ePWJhFWM9F
         n7XFFZwBu0lU/U3iKJi213A3Sz1FSpHiH+0yAbBDCCDZE9Vzp6sEOIXR/S0oCokWiGFX
         MgrJEScsWA3x3YqSGeBlP5FwDMtcNtpo+EJZ5poQGqJAyY1hoyXYTYSBvYnap78Co0my
         GN6TOAXaawPbOhFO4pm8pYAuvR0oQbLqUWnQ9C12q/RMYAL2i0H77cPP7N09M8nXH9Xv
         h43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=24L/BIzm6sbtPa+KU3nbZ+C2EQAQaJW1CfzY5s/lXddylZuC049me1EMGE10A4Mtwi
         JXfGblbsWoWKlhrTA8QFZE3MNz0qT1c16pcPRudsoCr4OwvP+25OXhQupu9XgAswiqlG
         SeRuhDtALF5sHEeLYh9TjRJKPxgpeUOtYfPOWep0X7Sspwea5N+19rnMiW/JqUgNnqIB
         ZfHQELoXDxzDvZDX/i9MUtvRQNldUg2zgp9PPVlEwmjRlWuewkKfOXVWdPj26D7bZ+Z1
         sdEaK9tCHTQc3Y9dqBMZmrdCqhkqyyJcJGCvkgiALYZli9JGMmkiUNue4NdIbfqVDBnm
         hbEQ==
X-Gm-Message-State: ACrzQf0QzKQ2dtsRDBTnCA+SXBODhIrkeVjSdkIRz1rDuAcC3TJQUYnU
        ACHyXhD9TiZC6euzt/CB6nNUgp/TfPM9fs96ndw=
X-Google-Smtp-Source: AMsMyM6DrY9ZuJ3m2AXSEmkCOD1mKv2pe+8Tp2Fu39gnnTRfrzWZFzEu4OoM3U02oe5qrguo58b2tSDsCVR7qkihP74=
X-Received: by 2002:a5b:651:0:b0:6be:faaa:d073 with SMTP id
 o17-20020a5b0651000000b006befaaad073mr4509922ybq.400.1665756098158; Fri, 14
 Oct 2022 07:01:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6c05:b0:3c1:5961:57b5 with HTTP; Fri, 14 Oct 2022
 07:01:37 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <goowjarwq@gmail.com>
Date:   Fri, 14 Oct 2022 16:01:37 +0200
Message-ID: <CAC-x_XGe_8Yh7Fyb1hTCNU2Rm3ZKQ2RoHmmTeC=35-gZMz9LQA@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


