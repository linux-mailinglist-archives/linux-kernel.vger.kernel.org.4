Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D86C2F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCUKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCUKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:55:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD1028EBD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:55:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so57868530edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679396142;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVw0iT4FSMRjIVx3X6H+mhmi1WAnugGzrc1l3XQuW3o=;
        b=awmAOj/kzNAqy2kY9hhPIkBVosyhUBjRPLy8fV2fJy6IdW4/oqq3JTjDArOJ9WSmxZ
         00MmqsiGcWrinLS/jItZnvYs4BOfC3xPvxTaHWBLeimvabbAPOT2+/7e0BScVfP33x8M
         Cq7CQdVxbDe8nMFDXtk4H9JL6viSZE8w50JvM7vBS+pLNLTm85j0kJ2HFJHa/0NI8N68
         D8pkgmCZbidhz7Jyy/L0n65DZcMZjxmK6eefI0BT8AOqIhLNF01j9D3iqf5rIGSbwY2T
         9pD9ZqYjBrHWt+yJa8Mi0Dlgnqyxa2rtBFMMuxEthbdiepkNzVMznpAcZigA3rdAciWs
         SjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396142;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVw0iT4FSMRjIVx3X6H+mhmi1WAnugGzrc1l3XQuW3o=;
        b=1QxFncoy6XvXXg1648MIXZU3WWEkhwrj/P0J3BgQWnzcmSwIXMUVI+NZrjF2ZE29XB
         uial00OrvYOZTO6/UJhiHFiuV7vFvO00GOk4jg6v7BzMYtIQbAb4znQrrjChdvlog6dN
         0GPPvSD3UqBa7ptQJX9Ck3W4js1R68gghnePxFdtEXlZMhQIfM9XvP4c2NLlAYUfgn3h
         EL+f+r3a2e5JvGzRVL5AUHovm9W5Fusc3s4d69g1eRcBQHD2VKPzhFfwuUHgBP2B4gBW
         5c1i1zJTPRo69GwJ2hgf0Y6q7KdsX4XRUaR131j3z6QQckl/WD3nTcYk5Phk42dKciij
         acxA==
X-Gm-Message-State: AO0yUKXrCTocEMP4nBJByA963CQNYdYJTXPTB0GxvGhQv1xCpmMhJST6
        bEfNRqeAJQC0e0mCDf+DifPFwL/FEKybkgP3EVA=
X-Google-Smtp-Source: AK7set8JpgvHxrOeGI9ilSUNEnktOUUu1GZAHg9v7xuCWeWAy1jaJ7s/O7d5f+u9zP5IjXBQKHWEc/bICHmWJYAkPNE=
X-Received: by 2002:a17:906:6613:b0:92e:a234:110a with SMTP id
 b19-20020a170906661300b0092ea234110amr1070641ejp.3.1679396141866; Tue, 21 Mar
 2023 03:55:41 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Margaret <wwwtechdataservice@gmail.com>
Date:   Tue, 21 Mar 2023 05:55:31 -0500
Message-ID: <CAJ55j2X0DUqrasWQPvgL2qSL3R9GbowDMU-xFbKgNdMQ1h7yjQ@mail.gmail.com>
Subject: RE: FINE TECH Attendees Email List 2023
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring FINE TECH Attendees Databank?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts :5,759 Verified Contacts.
Cost                         : $ 1,486

We do have an all industry list and conference attendee list from
across the globe.

Kind Regards,
Emily Margaret
Marketing Coordinator

If you do not wish to receive future emails from us, please reply as
'leave out=E2=80=99.
