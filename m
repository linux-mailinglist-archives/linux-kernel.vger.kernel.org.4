Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973766EE9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjDYV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjDYV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:59:03 -0400
X-Greylist: delayed 2932 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 14:59:02 PDT
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B862A7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:59:02 -0700 (PDT)
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PJj3oG036664
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=20180315;
 bh=HKURM7lQwvlytFLh5YItjG4WpOjT7MPq3+fMeQnQZXU=;
 b=Q0+DTDrSpss/DG8Ckj0tfoNanZ2FghIYMzB1+ROTlVeANZgFMnRQi6GKHqKtatrly87L
 cNSP1vZUQi2tWZQ+gkfzgIp4rlgpk7CavDmOizj0EjQuAkT+bN+kIsi9yphkxV8iC34F
 GTPDn0LPWFG1yVaUECZ6nBNeBMx54HjcbM9z84nuwUsKaYL9fQNVCc+hycSgrueYY07R
 ptFb0Qi7J0CF/hbHvJ/l1QPNtD2omu6aW9KnuyeI7wCDgSnofKYdx897lCo55Mr5i7Ip
 YXrAoiZwjM3g9tlAk132Ui54OLHpU/rchNo1C4lMSTe2KtMpQyrwVncrpQeJCBmXbDJ4 1g== 
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3q60k7vkja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:10:09 -0400
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef4b68f47bso39218506d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457008; x=1685049008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKURM7lQwvlytFLh5YItjG4WpOjT7MPq3+fMeQnQZXU=;
        b=BydGrv/ljoYW/pGEQBcGVz9oxFzP/5/wZfcdMrUCVAD04lK1XnRVmGAVCy9QIPrtrV
         S0tBUWnsXjyw7TiLednZvN+TklMhtL4tJgG3exmMW/gw8eeZV1FKuCnnlMsEtc0HFqlm
         O9CtDek5gtEpuZLRlj3gn+bgfhEUWPgU4FutQpGudhgBrCIx3l0L7oYFlFGnu5Htz0VW
         loOgr77WuHRMYKOVYmSYwEg1ouquVMFcEvlVVh6WtjTZaIm3BE11oBVam/xQXQx6Ywld
         OpSEwIDddFXc840tTKrTW0+YSBtEZn3nbz5Vi3guHS4oZhUDJ+8BW668HSbt0WJOsinY
         KSQg==
X-Gm-Message-State: AAQBX9d+0dWZpVViZXBs0cUVceZb0BJKQA6pOaaklMlRtlzw+AHnJHDz
        Hfc3gV5WrTRS23dPRTWb+a+aIGEflHEOA8URXHE87HbiPXU+slVMiSjr/Ha7nxTwiTl4IhYWJ3t
        AbCz8o8gKne02Er/2v++8y2A=
X-Received: by 2002:a05:6214:501c:b0:56e:a9c6:d2c6 with SMTP id jo28-20020a056214501c00b0056ea9c6d2c6mr34737617qvb.6.1682457008174;
        Tue, 25 Apr 2023 14:10:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8H6oImKBsfMaSxwrjO9SgDN2vDovPneV/eC15FQgUsEGJOE/Q4cqdZT8/846IvUJYy9B0VA==
X-Received: by 2002:a05:6214:501c:b0:56e:a9c6:d2c6 with SMTP id jo28-20020a056214501c00b0056ea9c6d2c6mr34737591qvb.6.1682457007932;
        Tue, 25 Apr 2023 14:10:07 -0700 (PDT)
Received: from enviable.nyu.edu (216-165-95-139.natpool.nyu.edu. [216.165.95.139])
        by smtp.gmail.com with ESMTPSA id n16-20020a0cdc90000000b005ef589381a8sm4341426qvk.52.2023.04.25.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:10:07 -0700 (PDT)
From:   Jonathan Singer <jes965@nyu.edu>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Singer <jes965@nyu.edu>
Subject: Re: Function of the camera key on windows
Date:   Tue, 25 Apr 2023 17:09:53 -0400
Message-Id: <20230425210953.14597-1-jes965@nyu.edu>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <MN0PR12MB6101D9688E7904FF52634520E2649@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB6101D9688E7904FF52634520E2649@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bnWunJyKVm1U8Q5s0LT4iINqhFU2AWHM
X-Proofpoint-GUID: bnWunJyKVm1U8Q5s0LT4iINqhFU2AWHM
X-Orig-IP: 209.85.219.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=1 mlxscore=1 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=1 mlxlogscore=201 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250188
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The key itself triggers a hardware response both on windows and linux.
It disconnects power from the camera USB module and raises a cover in front
of the camera aperature. The keycode is as far as I know only to notify the
operating system in case it wanted to show a message.

Is that the kind of use case that would benefit from emitting a KEY_CAMERA?
