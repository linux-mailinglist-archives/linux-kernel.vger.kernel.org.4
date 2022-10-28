Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A03610F57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJ1LGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1LGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:06:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D731D0D5C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:06:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r83so5783211oih.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao6xA7ksg6B7+lAx5GqKZpgoR/eUc6sPjbkwHRSYdHM=;
        b=aT7AOSVtBo0g3kzIHYAlQS61hmHdxxL163JLx1M8fsB8G7kKUeErj1oyxS9pF2GR2I
         PH/Q3Jbr+TKxGhGaFSdGQ0vA9rR9rgvVSf55T/ZuR6JXn1HW6IxMla6XYSMfgrZztOln
         8iVgXmZy4hkqNsrtCPZ6/abFLMibY8aPJZnsaGC2vT/eehfIlxmUJGsqP+q4yP9xMxz8
         Drd17fjUEB6q8wMdfL9HzKOTl1d0vPKznUtRiwyvgFbJR+iEol7jYbUeLsXQfmpofDQ7
         yY2TROmQd6cU3ihGuMRB7U2Yp9SaC/If1WeeQF/rAJZ+M5c9E42/WVZYX7coS8djGvuX
         43bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao6xA7ksg6B7+lAx5GqKZpgoR/eUc6sPjbkwHRSYdHM=;
        b=iZNh9urOHj5wZlx4hqBNWSuSDM1sUFj+PWQxfaf6n6Z09o8UyplIBCooXNq7LKPIHO
         50OxZuUzHJTVCCrGjfP3IkTB2zJbJrHJj/JJ1aqF/ttQ2pCEKx29X9ABDE4J5/5kUqFm
         nJ/o+Gmwt/qIH+spdQZNR/2W+aqba/KEDNEPUhJ+ban0tiAntHfZ9zftucP9Ka96BrU6
         jnVhbePZd2Hm6tnJtDhjeBXa6OD+a8S6pEINtMHOEHhzxEGO0xjxoXXfCwWw7IpyTXDj
         CWchARi2nn9L7eFAi0EFg6aonuao6kIMTx5uA/f/mNsyHx+dzF6BKi65Nm1GZ0q/wwZQ
         hXHg==
X-Gm-Message-State: ACrzQf07iFWEVwYsUkeq6TbquGyz0GqfA0olUUnBRkM+/tqCfbQg+2Gf
        BlQE0KDAxUsePHByYdoawQV0ZrCaeZ2e2zlIJk0=
X-Google-Smtp-Source: AMsMyM4SEcGa4az46140UGz4w8dobUs3BhHhjj1Z5ndjq/3nGORBpRUGfWlOj00hu70Y96yGIOjmvKQA/lmYK0kMSbU=
X-Received: by 2002:a05:6808:2190:b0:355:4d53:eb07 with SMTP id
 be16-20020a056808219000b003554d53eb07mr7595791oib.127.1666955192489; Fri, 28
 Oct 2022 04:06:32 -0700 (PDT)
MIME-Version: 1.0
From:   Randy Smith <www.techbusinessdatasolutions@gmail.com>
Date:   Fri, 28 Oct 2022 06:06:20 -0500
Message-ID: <CAN+x3vwHgvCBWjx8sfxQh1QAPwt-95u_DR8C3j0cxAHHknQjfg@mail.gmail.com>
Subject: RE: Verified Dreamforce Attendees Databank-2022
To:     Randy Smith <www.techbusinessdatasolutions@gmail.com>
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

Hi ,

Would you be interested in acquiring Dreamforce Attendees Databank 2022?

List Includes:- Hospital/Clinic/Org-Name, First Name, Last Name,
Contact Job Title, Verified Email Address, Website URL, Mailing
Address, Phone Number, Fax Number, Industry and many more=E2=80=A6

 Number of Contacts : 40,227 Verified Contacts.
Cost                           : $1,825

 Kindly let me know your thoughts so that we could discuss further.

We do have an all industry list and conference attendee list from
across the globe.

Kind Regards,
Randy Smith
Marketing Coordinator

 If you do not wish to receive future emails from us, please reply as
'leave out=E2=80=99
