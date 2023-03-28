Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B16CB439
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjC1CjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC1CjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:39:12 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4319BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:39:11 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p2so5565321qtw.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679971150;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU2jhhwAwjYUv533PYlOK7xEtvDPc6ET4YxjklYFV+M=;
        b=Cxc97O3lRyy5/47Dm6pJ5ld65NDtOoXS+ySdnGHYbzYKdkUr3wfDNwIr4jxrZ7p/aH
         y4IgNxF0WvIqQQ9U08TyKuJGQlMb4RZG9feF5Iamsh2Jn/cQGYfrSMeHYdJAlTiiQF0y
         NKbZ3K6PJr0wQzyXsQx3rdFDwkie8MfMJ/g9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679971150;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU2jhhwAwjYUv533PYlOK7xEtvDPc6ET4YxjklYFV+M=;
        b=4msJQm6cRr5nm3RDsjJgOf7nn5/QnjfXjpi/oiIxSwBbF5Rr2JckIs8JIG4WY3YdEx
         1N1ILNf26D/il36u4yOZIWXFy63NjTv1DI2iS8WTCi2C+RuzqVUZfCFOUSF3PHIbcZha
         ZRxno0nWpPNlI6efCTAmAqyhHwLr91xbg9ke77KX5R9FOC4ufaam10BHEaGR0qEVGytu
         smsqZ1PnGmq9TkseV0X7dldm3sgnyO8WwmHD0cOcaDexV1H52LYEUgralQki3fBWkvYQ
         FfD3XA24w0fhVoullOLhnPG6bnNCNYm2YPUcdm/XEEoET7ormmldQOf2+z4FPMQdemap
         R8xQ==
X-Gm-Message-State: AAQBX9eCgAjYl5LEkb63D35Qtt7jrDpkoUARHrN6qnFUVRwHjaUt8dn4
        9bIHluYvzqWQ76+EHocb1wQ8eGksv/XZXqN72HM=
X-Google-Smtp-Source: AKy350aNg8VRJb7Q9rz+hY9fAPeUdYuJMuQ/aJHf8U541/qaS2ppI6A+BwbEs6c7EgPzA5dR6eJl/w==
X-Received: by 2002:ac8:5a93:0:b0:3e4:e80b:4613 with SMTP id c19-20020ac85a93000000b003e4e80b4613mr9773807qtc.2.1679971150466;
        Mon, 27 Mar 2023 19:39:10 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b130:c6c6:6401:1533:c2de:a27d])
        by smtp.gmail.com with ESMTPSA id p10-20020ac8740a000000b003e4d1d5ec8bsm2782801qtq.52.2023.03.27.19.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 19:39:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] MAINTAINERS: Add Zqiang as a RCU reviewer
Date:   Mon, 27 Mar 2023 22:38:59 -0400
Message-Id: <92DFB431-AF9B-4175-802F-6777E2CDE802@joelfernandes.org>
References: <PH0PR11MB588003A83F9F477339BA6B49DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB588003A83F9F477339BA6B49DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 23, 2023, at 10:24 PM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote=
:
>=20
> =EF=BB=BF
>>=20
>> On Thu, Mar 23, 2023 at 12:07:29PM +0800, Zqiang wrote:
>> I have spent about two years studying and contributing to RCU,
>> and sharing RCU-related knowledge within my team, if possible,
>> please consider me as R ;-).
>>=20
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>=20
>> I am pulling this and the one adding Boqun for 6.4 based on discussion wi=
th Paul.
>=20
> Thanks Joel,  looking forward to our more discussions

Same here!!! Thanks. :-)

- Joel=20




>=20
>>=20
>> Congrats. ;-)
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>> ---
>> MAINTAINERS | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8d5bc223f305..b304d3c7b45b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17642,6 +17642,7 @@ R:    Steven Rostedt <rostedt@goodmis.org>
>> R:    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> R:    Lai Jiangshan <jiangshanlai@gmail.com>
>> R:    Joel Fernandes <joel@joelfernandes.org>
>> +R:    Zqiang <qiang1.zhang@intel.com>
>> L:    rcu@vger.kernel.org
>> S:    Supported
>> W:    http://www.rdrop.com/users/paulmck/RCU/
>> --=20
>> 2.25.1
>>=20
