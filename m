Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157A86C7246
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCWVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCWVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:25:54 -0400
X-Greylist: delayed 3754 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 14:25:50 PDT
Received: from symantec.comsats.net.pk (symantec.comsats.net.pk [210.56.11.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429AE27980
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:25:49 -0700 (PDT)
X-AuditID: d2380b23-20fff70000007bb6-44-641ca6333210
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 5A.E5.31670.336AC146; Fri, 24 Mar 2023 00:19:15 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=DsPNZxr99QisNuMt+BVycUQc2+sWE5drIknSNqeIUGWoX+BQsNQ//yHbHi2+B8s0o
          M0GUI2H7UB5jwfDVhpvkx/8khK9R8kN0Gof04n7B9PyZtrPQ4GCperVfnIKeOKOCc
          i8ET6fBNGUE8jGg9K03WUbujMt50lmiDQg0fn5KcE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=Itfook3eFdnCA07V/BXRoZa7udW6dLZPW/uhwmxiEnq9zJSkfDD4UiXCk5fgZEQEM
          FgI9xQRU6Hj9LxNn4Vyp85Ev7PM2Z8ASYbq44vDfd3CiI0wOilR3enBm0Sqb5GwAM
          eSkqJDdYHHdnxIRERk5fPcMu7h83WMrzotqRnEA1M=
Received: from [194.55.224.249] (UnknownHost [194.55.224.249]) by iesco.comsatshosting.com with SMTP;
   Thu, 23 Mar 2023 23:54:46 +0500
Message-ID: <5A.E5.31670.336AC146@symantec.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest!
To:     linux-kernel@vger.kernel.org
From:   "Chen Yun" <sa3_ami@iesco.com.pk>
Date:   Thu, 23 Mar 2023 12:27:55 -0700
Reply-To: cchycnn@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGc3ov5a70sttbBu9KR8x1YnSzkwUNm18zRoLDKfEj0cUFbts7
        WikFewsOYxyKga4yBhvdWIfyNVgExh+wdeCkM51L6KJuYsVOGRsZ3YRFMFswSyTouaWl/efk
        5Pe8532fc557KYL9mdJQZqtdsFl5CydXkOM52qQnnu7RGp/82puZ88s3rfIdKO/+YEYB2q14
        1ihYzJWCbcvzRQrTyYGrZPl5Yl/toU6yGt2SOdEaCphs+PHO0UQnUlAsc14GPc2uREkgmT4C
        hv1qSSCZaQJ+n38QqTqA4PLA2QSpima2Q41/Ti7tCUYHQVezfIWrwH98hlzhm6Cn4y7hRBTe
        Z8Ki0y5hNZMKE9cd4WEpzEMwdPB2glQiZx6F1r/zVjw8AiHXdLgjy6TD4Qu1iY1orTtumDtu
        mDtumDs2rB2RvShNrCrl8aMZdIayUpG3izqrYNeVlwyi8AsmPTyMuhoLfYihEKekoVhrZBP4
        SnzIh/IpGbeOhrfTjWyyvsxYZeJFU6GtwiKIXApdcApX0qtYX2Ep4TR0QSem6lVqFT4ULYId
        R+ZDQBH4WC4B+JiRr/pIsJWtNPOhdIrk0mht5m0DyxTzdqFEEMoFW1R9i6I4oLd24c4qm1As
        7NtrttijMj5X0YoVJl4Jm9lAq3KwkBovxPuRUWt8KI9SYlOF3dJdxHK+VDQXR/qq6a+OYaqM
        0nDP9bROuiAbhbF+l5GZuhG4OkpQix7ndwRLWsusgiaN3nxcMifVmyqsq641qXSuCwtr4wRp
        gEZLTx3BfF0cj82IfvNzaAnhtNQ0J/lW4l8iZpulGTeGSREYdg30M5JrVYTFGm49g/sw/TLw
        /unPgC7PYgY0LLdz8OvID1kQCF3PhrFznm0QvDS7DfrHpl6BgOvmLrgUGn0Dxk/XvAuT907s
        gcF/A0WwfCWoh5Zax17o++NwKVw4GPgAAgsthxCMjyy5EPSNtx5DcP8/L16vDTtaEJxpm2lD
        sHjyRDuCbzsmOhA4OpsuImh2D3+PYOlc0ySCB/VN0wjaPhtbwDWf38RrcPnuPTSHY5Ph2F76
        OBybnbfHx+apC8cWoZHYhurCsUVg7AU01UjwTFQqldUveidSd6U0v1+1cOtUgeZGQ3c2OTmq
        3zib2dke2rn+zhe5rz13JWvDOwOfdOe/OrTH0NC4fTMB+qx89YE3k2vakh/78nX/lN670fXX
        TzO9O0/3e997qm7LtZD37Min80HqH5Xr5ReObtrB5dVnXJz/bfesx1Dv2B8qKdrfq+BI0cRn
        PU7YRP5/l9PlQuQEAAA=
X-Spam-Status: No, score=4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

