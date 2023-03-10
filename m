Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A036B5440
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjCJW0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:26:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEDD1AC0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:26:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw28so26473349edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678487188;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QgANQIPfsm3NJ5At1Do8k2p89dCpDt7xQYwrUkYHLfM=;
        b=kM4Oxd8zDW6a2QGoLhzJSS+044s+JscuwdK3CZhQyxopPGRy31pJyaunuSd+aq+qGv
         i+qcB30Z9Ze/2A/9wOKGsHExNFGcUsermD9wwV9ryNZgSrjSvQLd7rhPvT9bVFxmaT9r
         MFRKDyF+miyhLC1Q+OPY+rXmXZSS/MEUvT6oIS/EVF/NwYNG9ITtNsuMwPIG9RVHDvkr
         MysrL8xLGv5VIcgnJwGUHs55nK/2bM/4WWv9vL0Ft4lTyjUjbj/4FuLBPtspqSGT9id4
         h5885XsZzrNVfCRk4uFUAwuIX8wejFqdhi7txSJne9bAgTR3RQTVaGrpBiUMz6J7iaKx
         BMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgANQIPfsm3NJ5At1Do8k2p89dCpDt7xQYwrUkYHLfM=;
        b=7+sS53deusjE6dZVkhM6fypBomAp4/23u97lSk4CQ9OFmR6YCNlW/6aBsHuxjy5TcI
         cEFynpou9aHyFJIEEiYxai66i9/XEFieoyJB0809ls4pAOU93oaDA90GGGhfrGn0uFl/
         e5Xlu5wHdxEPi6BA74N23QLYuqmAaxlMs7yuesI0koTqYSXtlYc48cu0aizVjX4i+hKU
         IpH1hmXpV2F+MMhzKyCoxN2MR24vYKs8/tV2uE0ajY3fY/qrRQVRgKLCo3WAzO0MWk1/
         AYd1bPyF1FYiBmKF4XjBF/VrA3RcbPLkSlQzd2vZ4WJAx1XECUV9pGzBqC1Kyx2M1j5v
         FWaA==
X-Gm-Message-State: AO0yUKVMaUd+Uk0v+Qi+taQflttxdGxf+s0Jpf63WgENeGfc4vHWusdw
        sMT0C7LOPh1Mfyi1PpZ/BJP4MkoFuHAuDq4Wzqo=
X-Google-Smtp-Source: AK7set9fOKbCoRtM3Xdk5F3kzcWDRMycANItl6l0NsfErynLNqrTpNKHxIvtaWNT61DWHRbJQaZId3tIQgEL1NVuLbA=
X-Received: by 2002:a50:d615:0:b0:4bb:c90e:1fa5 with SMTP id
 x21-20020a50d615000000b004bbc90e1fa5mr14802515edi.8.1678487188384; Fri, 10
 Mar 2023 14:26:28 -0800 (PST)
MIME-Version: 1.0
From:   Samantha James <quickerlist@gmail.com>
Date:   Fri, 10 Mar 2023 16:26:11 -0600
Message-ID: <CAMwiB3A97naytPebTkrvzKRoSeaXmREg023Ot=i6eLKAXP35Bg@mail.gmail.com>
Subject: RE: Gartner Data & Analytics Summit- Attendees Email- 2023
To:     Samantha James <quickerlist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Would you be interested in acquiring Gartner Data & Analytics Summit
Attendees Data List 2023?

You'll get access to 10,386 opt-in contacts, including their
organization name, first and last name, contact job title, verified
email address, website URL, mailing address, phone number, fax number,
industry, and much more.

No of Contacts:- 10,523
Cost: $1,626

Contact us today to purchase Gartner Data & Analytics Summit Attendees
Data List or for more information.

Best regards,
Samantha James
